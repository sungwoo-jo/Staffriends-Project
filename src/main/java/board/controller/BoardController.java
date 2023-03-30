package board.controller;

import board.dto.BoardDto;
import board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping({"/", ""})
    public String index() throws Exception {
        return "/index";
    }

    @RequestMapping("/board") // 게시글 목록
    public String openBoardList(Model model) throws Exception {
        List<BoardDto> list = boardService.selectBoardList();

        model.addAttribute("list", list);

        return "/board/boardList";
    }

    @RequestMapping("/board/boardWrite") // 글 작성 페이지
    public String BoardWrite() throws Exception {
        return "/board/boardWrite";
    }

    @RequestMapping("/board/insertBoard") // 글 작성 로직
    public String insertBoard(BoardDto boardDto) throws Exception {
        boardService.insertBoard(boardDto);
        return "redirect:/board";
    }

    @RequestMapping("/board/boardDetail") // 글 상세 보기
    public String openBoardDetail(@RequestParam int boardIdx, Model model) throws Exception {
        BoardDto boardDto = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("board", boardDto);

        return "/board/boardDetail";
    }

    @RequestMapping("/board/updateBoard") // 글 수정
    public String updateBoard(BoardDto boardDto) throws Exception {
        boardService.updateBoard(boardDto);
        return "redirect:/board";
    }

    @RequestMapping("/board/deleteBoard") // 글 삭제
    public String deleteBoard(BoardDto boardDto) throws Exception {
        boardService.deleteBoard(boardDto);
        return "redirect:/board";
    }

}
