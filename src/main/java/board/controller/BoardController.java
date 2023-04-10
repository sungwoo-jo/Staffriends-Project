package board.controller;

import board.vo.BoardVo;
import board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping({"/", ""})
    public String index() throws Exception {
        return "/index";
    }

    @RequestMapping("/board") // 커뮤니티
    public String boardList(Model model, HttpServletRequest request) throws Exception {
        String tempPage = request.getParameter("page");
        Map<String, Integer> map = new HashMap<String, Integer>();
        int cPage;
        int currentBlock;
        int pageLength = 10; // 게시글을 몇 개씩 보여줄 건지
        int startPage;
        int endPage;
        int totalRows = boardService.getTotalRows(); // 전체 행 개수
        int totalPages;
        int start; // SQL 쿼리의 LIMIT에 들어갈 변수

        // cPage(현재 페이지 정하기)
        if (tempPage == null || tempPage.length() == 0) { // 파라미터로 전달받은 페이지 정보가 없거나 0이면 1페이지
            cPage = 1;
        }
        try {
            cPage = Integer.parseInt(tempPage); // 파라미터로 전달받은 페이지 번호를 현재 페이지에 변환하여 담아줌
        } catch (NumberFormatException e) { // 에러 발생 시 1페이지로 이동
            cPage = 1;
        }

        totalPages = totalRows % pageLength == 0 ? totalRows / pageLength : (totalRows / pageLength) + 1; // 필요한 총 페이지의 개수는 데이터의 개수를 보여줄 게시글의 개수로 나누어 딱맞으면 0, 아니면 1개의 페이지를 더 생성해주면 된다.
        if (totalPages == 0) { // 데이터가 적은 경우 1페이지 생성
            totalPages = 1;
        }

        if (cPage > totalPages) {
            cPage = 1;
        }

        // currentBlock: 현재 위치한 페이지 블럭
        // cPage: 현재 페이지
        // pageLength: 전체 페이지 길이
        // startPage: 페이지 블럭의 가장 첫번째 번호
        // endPage: 페이지 블럭의 가장 마지막 번호

        // 페이지 처음과 끝을 지정하는 부분
        currentBlock = cPage % pageLength == 0 ? cPage / pageLength : (cPage / pageLength) + 1;
        startPage = (currentBlock - 1) * pageLength + 1;
        endPage = startPage + pageLength - 1;
        // 마지막 페이지 묶음에서 총 페이지수를 넘어가면 끝 페이지를 마지막 페이지 숫자로 지정
        if (endPage > totalPages) {
            endPage = totalPages;
        }

        start = (cPage - 1) * pageLength;

        map.put("start", start);
        map.put("pageLength", pageLength);

        List<BoardVo> list = boardService.selectBoardList(map);

        model.addAttribute("list", list);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("cPage", cPage);

        return "/board/boardList";
    }

    @RequestMapping("/board/boardWrite") // 글 작성 페이지
    public String boardWrite() throws Exception {
        return "/board/boardWrite";
    }

    @RequestMapping("/board/insertBoard") // 글 작성 로직
    public String insertBoard(BoardVo boardVo, @RequestParam String username) throws Exception {
        System.out.println(username);
        System.out.println(boardVo.getTitle());
        System.out.println(boardVo.getContents());
        boardVo.setCreatorId(username);
        boardService.insertBoard(boardVo);
        return "redirect:/board";
    }

    @RequestMapping("/board/boardDetail") // 글 상세 보기
    public String boardDetail(@RequestParam int boardIdx, Model model) throws Exception {
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("board", boardVo);

        return "/board/boardDetail";
    }

    @RequestMapping("/board/updateBoard") // 글 수정
    public String updateBoard(BoardVo boardVo) throws Exception {
        boardService.updateBoard(boardVo);
        return "redirect:/board";
    }

    @RequestMapping("/board/deleteBoard") // 글 삭제
    public String deleteBoard(BoardVo boardVo) throws Exception {
        boardService.deleteBoard(boardVo);
        return "redirect:/board";
    }



}
