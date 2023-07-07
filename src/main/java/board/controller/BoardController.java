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

    @GetMapping("/board/list") // 게시글 리스트 출력 및 페이징
    public ModelAndView boardList(HttpServletRequest request) throws Exception {
        int bgno = Integer.parseInt(request.getParameter("bgno"));
        String page = request.getParameter("page");
        System.out.println("page:"+page);
        System.out.println("bgno:"+bgno);
        ModelAndView mv = new ModelAndView();
        PagingVo pagingVo = boardService.paging(page, bgno); // 쿼리 스트링의 페이지 번호를 전달
        List<BoardVo> list = boardService.selectBoardList(pagingVo);
        System.out.println("pagingVo:"+pagingVo);
        System.out.println("list:"+list);

        mv.addObject("list", list); // 게시글 정보(BoardVo)
        mv.addObject("paging", pagingVo); // 페이징 정보(PagingVo)
        mv.setViewName("/board/list");
        return mv;
    }

    @GetMapping("/board/write") // 글 작성 페이지
    public String boardWrite(HttpServletRequest request, Model model) {
        model.addAttribute("bgno", request.getParameter("bgno"));
        return "/board/write";
    }

    @PostMapping("/board/write") // 글 작성 로직
    public String insertBoard(BoardVo boardVo, @RequestParam String username, @RequestParam String nickname, HttpServletRequest request) throws Exception {
        boardVo.setUsername(username);
        boardVo.setNickname(nickname);
        boardVo.setBgno(Integer.parseInt(request.getParameter("bgno")));
        boardService.insertBoard(boardVo);
        return "redirect:/board/list?bgno=" + boardVo.getBgno();
    }

    @GetMapping("/board/{boardIdx}") // 글 상세 보기
    public String boardDetail(@PathVariable("boardIdx") int boardIdx, Model model, HttpServletRequest request) throws Exception {
        System.out.println("@@@@ boardDetail 진입 @@@@");
        System.out.println("bgno:"+request.getParameter("bgno"));
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("board", boardVo);
        model.addAttribute("bgno", request.getParameter("bgno"));

        return "/board/detail";
    }

    @GetMapping("/board/update/{boardIdx}") // 글 수정 폼 요청
    public String updateForm(@PathVariable("boardIdx") int boardIdx, Model model, HttpServletRequest request) throws Exception {
        System.out.println("updateForm 진입");
        int bgno = Integer.parseInt(request.getParameter("bgno"));
        System.out.println("bgno:"+bgno);
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("boardVo", boardVo);
        model.addAttribute("bgno", bgno);
        return "/board/update";
    }

    @PostMapping("/board/update") // 글 수정 요청
    public String modifyBoard(Model model, BoardVo boardVo, HttpServletRequest request) throws Exception {
        System.out.println("modifyBoard 진입");
        int bgno = Integer.parseInt(request.getParameter("bgno"));
//        int bgno = boardVo.getBgno();
        System.out.println("bgno:"+bgno);
        boardService.updateBoard(boardVo);
        model.addAttribute("boardVo", boardVo);
        model.addAttribute("bgno", bgno);
        return "redirect:/board/" + boardVo.getBoardIdx() + "?bgno=" + bgno;
    }

    @ResponseBody
    @DeleteMapping("/board/delete/{boardIdx}") // 글 삭제
    public String deleteBoard(@PathVariable("boardIdx") int boardIdx) throws Exception {
        System.out.println("@@@ DELETE BOARD 진입 완료 @@@ ");
        boardService.deleteBoard(boardIdx);
        return "deleteSuccess";
    }

}
