package com.devpro.yuubook.controllers.clients;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.entities.Contact;
import com.devpro.yuubook.services.ContactService;

@Controller
public class ContactController extends BaseController{
	@Autowired 
	private ContactService contactService;
	
	@GetMapping("/contact")
	public String index(ModelMap model) {
		return "contact";
	}
	
	@PostMapping("/save-contact")
	public ResponseEntity<AjaxResponse> saveContact(ModelMap model, @RequestBody Contact contact){
		Contact contactResp = contactService.save(contact);
		if(contactResp!=null) {
			return ResponseEntity.ok(new AjaxResponse("Cảm ơn đã liên hệ với chúng tôi.",200));
		}
		return ResponseEntity.ok(new AjaxResponse("Không thể gửi. Vui lòng thử lại",400));
	}
}
