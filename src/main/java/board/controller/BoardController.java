package board.controller;

import board.vo.BoardVo;
import board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping("/reply")
    public String reply() {
        return "/reply/replyTest";
    }

    @RequestMapping("/boardList") // 게시글 리스트 출력 및 페이징
    public ModelAndView boardList(HttpServletRequest request) throws Exception {
        System.out.println("page:"+request.getParameter("page"));
        ModelAndView mv = new ModelAndView();
        Map<String, Integer> map = boardService.paging(request.getParameter("page")); // 쿼리 스트링의 페이지 번호를 전달

        List<BoardVo> list = boardService.selectBoardList(map); // 게시글 정보(BoardVo)
        int startPage = map.get("startPage"); // 시작 페이지 번호
        int endPage = map.get("endPage"); // 끝 페이지 번호
        int totalPages = map.get("totalPages"); // 전체 페이지 갯수
        int cPage = map.get("cPage"); // 현재 페이지 번호

        mv.addObject("list", list);
        mv.addObject("startPage", startPage);
        mv.addObject("endPage", endPage);
        mv.addObject("totalPages", totalPages);
        mv.addObject("cPage", cPage);
        mv.setViewName("/board/boardList");
        return mv;
    }

    @RequestMapping("/board/boardWrite") // 글 작성 페이지
    public String boardWrite() {
        return "/board/boardWrite";
    }

    @RequestMapping("/board/insertBoard") // 글 작성 로직
    public String insertBoard(BoardVo boardVo, @RequestParam String username, @RequestParam String nickname) throws Exception {
        boardVo.setUsername(username);
        boardVo.setNickname(nickname);
        boardService.insertBoard(boardVo);
        return "redirect:/board";
    }

    @RequestMapping("/board/boardDetail") // 글 상세 보기
    public String boardDetail(@RequestParam int boardIdx, Model model) throws Exception {
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("board", boardVo);

        return "/board/boardDetail";
    }

    @RequestMapping("/board/updateForm") // 글 수정 폼 요청
    public String updateForm(@RequestParam int boardIdx, Model model) throws Exception {
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("boardVo", boardVo);
        return "/board/updateForm";
    }

    @RequestMapping("/board/modifyBoard") // 글 수정 요청
    public String modifyBoard(Model model, BoardVo boardVo) throws Exception {
        int boardIdx = boardVo.getBoardIdx();
        boardService.updateBoard(boardVo);
        model.addAttribute("boardVo", boardVo);
        return "redirect:/board/boardDetail?boardIdx="+boardIdx;
    }

    @RequestMapping("/board/deleteBoard") // 글 삭제
    public String deleteBoard(BoardVo boardVo) throws Exception {
        boardService.deleteBoard(boardVo);
        return "redirect:/board";
    }

}
