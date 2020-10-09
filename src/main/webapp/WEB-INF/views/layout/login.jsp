<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<div class="box-model">
	<div class="model">
		<div class="model-title">
			Đăng Nhập <span id="close-model"><img src="images/close.png"
				alt="" class="img-fluid"></span>
		</div>
		<div class="model-body">
			<form action="">
				<div class="input-group">
					<label for="email">Email <span class="req">*</span></label> <input
						type="text" id="email">
				</div>
				<div class="input-group">
					<label for="pass">Mật khẩu <span class="req">*</span></label> <input
						type="password" id="pass">
				</div>
				<div class="controls">
					<div class="check">
						<input type="checkbox" name="" id="remember"> <label
							for="remember">Ghi nhớ mật khẩu</label>
					</div>
					<a href="#">Quên mật khẩu?</a>
				</div>
				<div class="input-group">
					<input type="submit" value="Đăng Nhập">
				</div>
				<p>
					Chưa có tài khoản vui lòng <a href="#">ĐĂNG KÝ</a>
				</p>
			</form>
		</div>
	</div>
</div>
