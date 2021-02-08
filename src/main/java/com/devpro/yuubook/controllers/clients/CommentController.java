package com.devpro.yuubook.controllers.clients;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.dto.CommentDTO;
import com.devpro.yuubook.models.entities.Comment;
import com.devpro.yuubook.services.CommentService;

@Controller
public class CommentController extends BaseController{
	@Autowired
	private CommentService commentService;
	
	@PostMapping("/rate-product")
	public ResponseEntity<AjaxResponse> saveComment(ModelMap model, @RequestBody CommentDTO commentDTO){
		if(userLogin() == null) {
			return ResponseEntity.ok(new AjaxResponse("Vui lòng đăng nhập để đánh giá.",400));
		}
		commentService.saveCommentByUserLogin(userLogin(), commentDTO);
		return ResponseEntity.ok(new AjaxResponse("Cảm ơn bạn đã đánh giá sản phẩm của chúng tôi.",200));
	}
	
	@PostMapping("/comment/delete/{id}")
	public ResponseEntity<AjaxResponse> deleteComment(ModelMap model, @PathVariable("id") Integer cmtId){
		if(userLogin() == null) {
			return ResponseEntity.ok(new AjaxResponse("Lỗi.",400));
		}
		commentService.deleteCommentByUserLogin(userLogin(), cmtId);
		return ResponseEntity.ok(new AjaxResponse("Xóa thành công.",200));
	}
	
	@PostMapping("/comment/like/{id}")
	public ResponseEntity<AjaxResponse> likeComment(ModelMap model, @PathVariable("id") Integer cmtId){
		if(userLogin() == null) {
			return ResponseEntity.ok(new AjaxResponse("Vui lòng đăng nhập.",400));
		}
		Comment comment = commentService.likeComment(userLogin(), cmtId);
		return ResponseEntity.ok(new AjaxResponse(comment,200));
	}
	
	@PostMapping("/comment/dislike/{id}")
	public ResponseEntity<AjaxResponse> dislikeComment(ModelMap model, @PathVariable("id") Integer cmtId){
		if(userLogin() == null) {
			return ResponseEntity.ok(new AjaxResponse("Vui lòng đăng nhập.",400));
		}
		Comment comment = commentService.dislikeComment(userLogin(), cmtId);
		return ResponseEntity.ok(new AjaxResponse(comment,200));
	}
}
