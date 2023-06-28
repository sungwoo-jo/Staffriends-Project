package board.controller;

import board.vo.BoardVo;
import board.service.BoardService;
import board.vo.PagingVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping({"/", ""})
    public String index() throws Exception {
        return "/index";
    }

    @GetMapping("/boardList") // 게시글 리스트 출력 및 페이징
    public ModelAndView boardList(HttpServletRequest request) throws Exception {
        System.out.println("page:"+request.getParameter("page"));
        ModelAndView mv = new ModelAndView();
        PagingVo pagingVo = boardService.paging(request.getParameter("page")); // 쿼리 스트링의 페이지 번호를 전달

        List<BoardVo> list = boardService.selectBoardList(pagingVo);

        mv.addObject("list", list); // 게시글 정보(BoardVo)
        mv.addObject("paging", pagingVo); // 페이징 정보(PagingVo)
        mv.setViewName("/board/boardList");
        return mv;
    }

    @GetMapping("/board/insertBoard") // 글 작성 페이지
    public String boardWrite() {
        return "/board/boardWrite";
    }

    @PostMapping("/board/insertBoard") // 글 작성 로직
    public String insertBoard(BoardVo boardVo, @RequestParam String username, @RequestParam String nickname) throws Exception {
        boardVo.setUsername(username);
        boardVo.setNickname(nickname);
        boardService.insertBoard(boardVo);
        return "redirect:/boardList";
    }

    @GetMapping("/board/{boardIdx}") // 글 상세 보기
    public String boardDetail(@PathVariable("boardIdx") int boardIdx, Model model) throws Exception {
        System.out.println("@@@@ boardDetail 진입 @@@@");
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("board", boardVo);

        return "/board/boardDetail";
    }

    @GetMapping("/board/updateForm/{boardIdx}") // 글 수정 폼 요청
    public String updateForm(@PathVariable("boardIdx") int boardIdx, Model model) throws Exception {
        System.out.println("updateForm 진입");
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("boardVo", boardVo);
        return "/board/updateForm";
    }

    @PostMapping("/board/modifyBoard") // 글 수정 요청
    public String modifyBoard(Model model, BoardVo boardVo) throws Exception {
        boardService.updateBoard(boardVo);
        model.addAttribute("boardVo", boardVo);
        return "redirect:/board/" + boardVo.getBoardIdx();
    }

    @ResponseBody
    @DeleteMapping("/board/deleteBoard/{boardIdx}") // 글 삭제
    public String deleteBoard(@PathVariable("boardIdx") int boardIdx) throws Exception {
        System.out.println("@@@ DELETE BOARD 진입 완료 @@@ ");
        boardService.deleteBoard(boardIdx);
        return "deleteSuccess";
    }

}
