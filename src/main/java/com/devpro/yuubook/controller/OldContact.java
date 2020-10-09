//package com.devpro.yuubook.controller;
//
//import java.time.LocalDateTime;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.ModelMap;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import com.devpro.yuubook.dto.AjaxResponse;
//import com.devpro.yuubook.entities.Contact;
//import com.devpro.yuubook.repositories.ContactRepo;
//
//@Controller
//public class OldContact {
//	@Autowired
//	private ContactRepo contactRepo;
////	Ajax
//	@PostMapping(value = "/save-contact-with-ajax")
//	public ResponseEntity<AjaxResponse> subscribe(@RequestBody /* final Map<String, Object> */ Contact data,
//			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
////		String name = String.valueOf(data.get("name"));// sử dụng Map
//		String name = String.valueOf(data.getName());
//		System.out.println(name);
//		data.setCreatedDate(LocalDateTime.now());
//		contactRepo.save(data);
//		return ResponseEntity.ok(new AjaxResponse("Conguration! You are subscribe successful!!!", 200));
//	}
//
//	@PostMapping(value = "/save-contact-with-ajax1")
//	public ResponseEntity<List<Contact>> getContact(final ModelMap model, final HttpServletRequest request,
//			final HttpServletResponse response) {
//		List<Contact> listContact = new ArrayList<>();
//		listContact.add(new Contact("Linh", "0986613124", "Subject 1", "Contect 1"));
//		listContact.add(new Contact("Lan", "0912839123", "Subject 2", "Contect 2"));
//		return new ResponseEntity<List<Contact>>(listContact, HttpStatus.OK);
//	}
//
////	Spring Form
//	@RequestMapping(value = "/contact", method = RequestMethod.GET)
//	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
//		model.addAttribute("contact", new Contact());
//		return "contact";
//	}
//
//	@RequestMapping(value = "/save-contact", method = RequestMethod.POST)
//	public String saveContact(@ModelAttribute("contact") Contact contact, ModelMap model, HttpServletRequest request,
//			HttpServletResponse response) {
//		System.out.println(contact.getName() + "-" + contact.getPhone());
//		return "contact";
//	}
//
////	no Spring Form
//	@RequestMapping(value = "/contact-no-springform", method = RequestMethod.GET)
//	public String contactNoSpringFormGet(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
//		model.addAttribute("message", "");
//		return "contact-no-springform";
//	}
//
//	@RequestMapping(value = "/contact-no-springform", method = RequestMethod.POST)
//	public String contactNoSpringFormPost(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
//		System.out.println(request.getParameter("name"));
//		System.out.println(request.getParameter("phone"));
//		return "contact-no-springform";
//	}
//	/*
//	 * Note: Khi k dùng spring form thì ở thẻ input nên thêm name="xxx"
//	 * 
//	 * 
//	 */
//}
////modelmap : trung gian, giúp giao tiếp dữ liệu modelAttribute
