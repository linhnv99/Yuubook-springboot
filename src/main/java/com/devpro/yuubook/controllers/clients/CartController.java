package com.devpro.yuubook.controllers.clients;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.dto.Cart;
import com.devpro.yuubook.models.dto.CartItem;
import com.devpro.yuubook.models.dto.CustomerAddress;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.repositories.ProvinceRepo;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.UserAddressService;

@Controller
public class CartController extends BaseController {
    @Autowired
    private BookService bookService;
    @Autowired
    private ProvinceRepo provinceRepo;
    @Autowired
    private UserAddressService userAddressService;

    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public String cartIndex() {
        return "cart";
    }

    @RequestMapping(value = "/cart/delivery-address", method = RequestMethod.GET)
    public String deliveryAddress(ModelMap model) {
        model.addAttribute("province", provinceRepo.findAll());
        return "delivery-address";
    }

    @RequestMapping(value = "/cart/cart-payment", method = RequestMethod.GET)
    public String cartPayment() {
        return "cart-payment";
    }

	@RequestMapping(value = { "/add-to-cart" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> addToCart(ModelMap model, HttpServletRequest request,
			HttpServletResponse response, @RequestBody CartItem cartItem) {
		HttpSession httpSession = request.getSession();
		// địa chỉ giao hàng
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomerAddress customerAddress = new CustomerAddress();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			customerAddress = userAddressService.getUserAddressByUserLogin(userLogin());
		}
		if (httpSession.getAttribute("DIA_CHI_KHACH_HANG") ==  null) {
			httpSession.setAttribute("DIA_CHI_KHACH_HANG", customerAddress);
		}

        // giỏ hàng
        Book book = bookService.getById(cartItem.getBookId());
        if (!book.isAct()) {
            return ResponseEntity.ok(new AjaxResponse("Sản phẩm đã tạm dừng bán.", 400));
        }
        cartItem.setBookName(book.getName());
        cartItem.setOriginPrice(book.getPrice());
        cartItem.setAvatar(book.getAvatar());
        cartItem.setDiscount(book.getDiscount());
        cartItem.setSlug(book.getSlug());

        Cart cart = null;

        if (httpSession.getAttribute("GIO_HANG") != null) {
            cart = (Cart) httpSession.getAttribute("GIO_HANG");
        } else {
            cart = new Cart();
            httpSession.setAttribute("GIO_HANG", cart);
        }
        List<CartItem> cartItems = cart.getCartItems();
        boolean isExists = false;
        for (CartItem item : cartItems) {
            if (item.getBookId() == cartItem.getBookId()) {
                isExists = true;
                item.setQuantity(item.getQuantity() + cartItem.getQuantity());
            }
        }
        if (!isExists) {
            cart.getCartItems().add(cartItem);
        }
        cart.calTotalPrice();
        return ResponseEntity.ok(new AjaxResponse(cart, 200));
    }

    @PostMapping("/remove-cart/{id}")
    public ResponseEntity<AjaxResponse> removeCart(@PathVariable("id") Integer id, HttpServletRequest request) {
        HttpSession httpSession = request.getSession();
        Cart cart = (Cart) httpSession.getAttribute("GIO_HANG");
        if (cart != null) {
            List<CartItem> cartItems = cart.getCartItems();
            for (int i = 0; i < cartItems.size(); i++) {
                if (cartItems.get(i).getBookId() == id) {
                    cart.getCartItems().remove(i);
                }
            }
            cart.calTotalPrice();
            return ResponseEntity.ok(new AjaxResponse(cart, 200));
        } else {
            return ResponseEntity.ok(new AjaxResponse("Không thể xóa.", 400));
        }
    }

    @PostMapping("/save-customer-address")
    public ResponseEntity<AjaxResponse> saveAddressTemp(HttpServletRequest request, @RequestBody CustomerAddress customerAddress) {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("DIA_CHI_KHACH_HANG", customerAddress);
        return ResponseEntity.ok(new AjaxResponse(customerAddress, 200));
    }
}
