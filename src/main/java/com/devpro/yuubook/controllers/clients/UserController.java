package com.devpro.yuubook.controllers.clients;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.entities.Order;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.models.entities.UserAddress;
import com.devpro.yuubook.repositories.ProvinceRepo;
import com.devpro.yuubook.services.CommentService;
import com.devpro.yuubook.services.OrderService;
import com.devpro.yuubook.services.UserAddressService;
import com.devpro.yuubook.services.UserService;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/profile")
public class UserController extends BaseController {
    @Autowired
    private UserService userService;
    @Autowired
    private ProvinceRepo provinceRepo;
    @Autowired
    private UserAddressService userAddressService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private CommentService commentService;

    @GetMapping("")
    public String index(ModelMap model) {
        model.addAttribute("user", userLogin());
        model.addAttribute("userAddress", userAddressService.getUserAddressByUserLogin(userLogin()));
        return "user/profile";
    }

    @GetMapping("/personal/info")
    public String personalInformation(ModelMap model) {
        model.addAttribute("user", userService.getUserByEmail(userLogin().getEmail()));
        return "user/personal-info";
    }

    @GetMapping("/address")
    public String userAddress(ModelMap model) {
        model.addAttribute("province", provinceRepo.findAll());
        model.addAttribute("userAddress", userAddressService.getUserAddressByUserLogin(userLogin()));
        return "user/user-address";
    }

    @GetMapping("/order")
    public String userOrder(ModelMap model) {
        model.addAttribute("orders", orderService.getOrdersByUserLogin(userLogin()));
        return "user/user-order";
    }

    @PostMapping("/order/delete/{id}")
    public ResponseEntity<AjaxResponse> deleteOrder(ModelMap model, @PathVariable("id") Integer id)
            throws IllegalStateException, IOException {
        Order order = orderService.getOrderById(id);
        if (order.getOrderStatus() != 0) {
            return ResponseEntity.ok(new AjaxResponse("Không thể hủy đơn hàng này.", 400));
        }
        orderService.deleteOrderById(id);
        return ResponseEntity.ok(new AjaxResponse("Hủy thành công.", 200));
    }

    @GetMapping("/order/deleted")
    public String orderDeleted(ModelMap model) {
        model.addAttribute("orders", orderService.getOrdersDeletedByUserLogin(userLogin()));
        return "user/order-deleted";
    }

    @GetMapping("/book/favorite")
    public String bookFavorites(ModelMap model) {
        return "user/book-favorite";
    }

    @GetMapping("/reviews")
    public String reviewsBook(ModelMap model) {
        model.addAttribute("comments", commentService.getCommentsByUserLogin(userLogin()));
        return "user/user-reviews";
    }

    @PostMapping("/save-profile")
    public ResponseEntity<AjaxResponse> saveProfile(ModelMap model, @RequestBody User user)
            throws IllegalStateException, IOException {
        userService.update(user);
        return ResponseEntity.ok(new AjaxResponse("Cập nhật thành công.", 200));
    }

    @PostMapping("/save-address")
    public ResponseEntity<AjaxResponse> saveUserAddress(ModelMap model, @RequestBody UserAddress userAddress)
            throws IllegalStateException, IOException {
        userAddressService.save(userAddress, userLogin());
        return ResponseEntity.ok(new AjaxResponse("Cập nhật thành công.", 200));
    }


    @PostMapping("/upload")
    public ResponseEntity<AjaxResponse> uploadAvatar(@RequestParam("file") MultipartFile file) throws IOException {

        User user = userService.updateAvatar(file, userLogin());
        if (user != null)
            return ResponseEntity.ok(new AjaxResponse("SUCCESS", 200));
        return ResponseEntity.ok(new AjaxResponse("ERROR", 400));
    }
}
