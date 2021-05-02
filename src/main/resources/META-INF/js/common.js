function likeComment(id) {
    $.ajax({
        url: "/comment/like/" + id,
        type: "post",
        dataType: "json",
        success: function (data) {
            if (data.statusCode == 400) {
                alert(data.obj)
                return;
            }
            if (data.statusCode == 200) {
                console.log(data.obj)
                $(".cmt-number" + id).html(data.obj.likeComment);
                $(".box-like" + id).empty();
                var html = "<a class='ml-2 text-primary' onclick='dislikeComment(" + id + ")' data-id=" + id + " }> Bỏ thích </a>";
                $(".box-like" + id).append(html);
            }
        },
        error: function (err) {
            console.log(err);
        }
    })
}

function dislikeComment(id) {
    $.ajax({
        url: "/comment/dislike/" + id,
        type: "post",
        dataType: "json",
        success: function (data) {
            if (data.statusCode == 400) {
                alert(data.obj)
                return;
            }
            if (data.statusCode == 200) {
                console.log(data.obj)
                $(".cmt-number" + id).html(data.obj.likeComment);
                $(".box-like" + id).empty();
                var html = "<a onclick='likeComment(" + id + ")'}><i class='ml-3 glyph-icon flaticon-like'></i> Thích</a>";
                $(".box-like" + id).append(html);
            }
        },
        error: function (err) {
            console.log(err);
        }
    })
}


$(document).ready(function () {

    $("#register-notify").on("click", function () {
        let email = $("#box-register-notify #noti-email").val().trim();
        let categoryId = $("#box-register-notify #category").val();

        if (email === "" || !validateEmail(email)) {
            alert("Email rỗng hoặc không hợp lệ!");
            return;
        }

        let data = {
            "name": name,
            "email": email,
            "categoryId": categoryId
        }

        $.ajax({
            url: "/notifications/registers",
            method: "POST",
            data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json",
            success: function (data) {
                alert(data.obj)
                $("#box-register-notify #noti-email").val("");
            },
            error: function (err) {
                console.log(err);
            }
        })
    })


    $.ajaxSetup({cache: false});
    $("#topSearch").on("submit", function () {
        var q = $("#keySearch").val().trim();
        if (q == "") {
            return false;
        }
    })

    $("#topSearch #keySearch").on("keyup", function (e) {
        var q = $(this).val().trim();
        var $result = $(".box-result-search");
        if (q == "" /*|| q.length < 2*/) {
            $result.empty().hide();
            return false;
        }
        if (e.keyCode == 32) {
            return false;
        }
        $.ajax({
            url: "/search-suggest?q=" + q,
            type: "get",
            dataType: "json",
            success: function (data) {
                if (data.statusCode == 200) {
                    if (data.obj.length > 0) {
                        var baseUrl = window.location.origin;
                        $result.empty();
                        $.each(data.obj, function (k, v) {
                            $result.append("<li>" +
                                "<a href='" + baseUrl + "/san-pham/" + v.slug + "'>" +
                                "<img width='40' height='40' src='" + baseUrl + "/files/" + v.avatar + "' >" + v.name +
                                " - <span class='text-primary'>" + v.authorName + "</span></a></li>" +
                                "</li>").show();
                        })
                    } else {
                        $result.empty().hide();
                    }
                }
            },
            error: function (err) {
                console.log(err);
            }
        })
    })


    $(".rate-form").on("submit", function (e) {
        e.preventDefault();
        var starInt = $(".rate-form .rate-now span > a.selected").data("star");
        var title = $("#rate-title").val().trim();
        var content = $("#rate-content").val().trim();
        var bookId = $("#rate-bookId").val();
        var data = {
            "star": starInt,
            "title": title,
            "content": content,
            "bookId": bookId
        }

        if (title == "") {
            alert("Tiêu đề không được để trống."); return;
        }
        if (content == "") {
            alert("Nội dung không được để trống."); return;
        }


        $.ajax({
            url: "/rate-product",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(data),
            dataType: "json",
            success: function (data) {
                if (data.statusCode == 400) {
                    alert(data.obj)
                    return;
                }
                if (data.statusCode == 200) {
                    alert(data.obj);
                    window.location.reload();
                }
            },
            error: function (err) {
                console.log(err);
            }
        })
    })

    $(".delete-comment").on("click", function (e) {
        e.preventDefault();
        if (!confirm("Bạn có chắc chắn muốn xóa?")) {
            return;
        }
        var id = $(this).data("id");
        $.ajax({
            url: "/comment/delete/" + id,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.statusCode == 400) {
                    alert(data.obj)
                    return;
                }
                if (data.statusCode == 200) {
                    alert(data.obj);
                    window.location.reload();
                }
            },
            error: function (err) {
                console.log(err);
            }
        })
    })


    $("#submit-contact").on("click", function (e) {
        e.preventDefault();
        name = $("#name").val();
        phone = $("#phone").val();
        content = $("#content").val();
        subject = $("#subject").val();
        if (!checkContactIsEmpty(name, phone, content, subject)) {
            alert("Vui lòng điền đầy đủ thông tin.");
            return false;
        }
        if (!validatePhone(phone) && phone != '') {
            alert("Số điện thoại không hợp lệ !");
            return;
        }

        $(".contact-loader").show();
        var data = {
            "name": name,
            "phone": phone,
            "content": content,
            "subject": subject
        };
        setTimeout(function () {
            $.ajax({
                url: "/save-contact",
                type: "post",
                contentType: "application/json", // dữ liệu gửi lên web-service
                // có dạng là json.
                data: JSON.stringify(data), // object json -> string json
                dataType: "json", // dữ liệu từ web-service trả về là json.
                success: function (data) { // được gọi khi web-service trả về dữ
                    // liệu.
                    if (data.statusCode == 400) {
                        alert(data.obj);
                        return;
                    }
                    if (data.statusCode == 200) {
                        $(".contact-loader").hide();
                        $("#name").val("");
                        $("#phone").val("");
                        $("#content").val("");
                        $("#subject").val("");
                        alert(data.obj);
                    }
                },
                error: function (err) {
                    alert("Đã xảy ra lỗi! Vui lòng thử lại sau.");
                    $(".contact-loader").hide();
                }
            });
        }, 2000);
    })

    function checkContactIsEmpty(name, phone, content, subject) {
        if (name.trim() == "")
            return false;
        else if (phone.trim() == "")
            return false;
        else if (content.trim() == "")
            return false;
        else if (subject.trim() == "")
            return false;
        else
            return true;
    }

    function validatePhone(phone) {
        var pattern = /^(84|0[3|5|7|8|9])+([0-9]{8})\b$/;
        if (pattern.test(phone))
            return true;
        return false;
    }

    function validateEmail(sEmail) {
        var pattern = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        return pattern.test(sEmail);
    }

    function validateInput(surname, name, email, password, confirmPass) {
        if (surname == '') {
            $("#errSurname").show().html("Họ đệm không được để trống.");
            return false;
        } else $("#errSurname").hide().html("");

        if (name == '') {
            $("#errName").show().html("Tên không được để trống.");
            return false;
        } else $("#errName").hide().html("");

        if (email == '') {
            $("#errEmail").show().html("Email không được để trống.");
            return false;
        } else $("#errEmail").hide().html("");

        if (!validateEmail(email)) {
            $("#errEmail").show().html("Email không đúng định dạng.");
            return false;
        } else $("#errEmail").hide().html("");

        if (password != null) {
            if (password == '') {
                $("#errPassword").show().html("Mật khẩu không được để trống.");
                return false;
            } else if (password.length < 6) {
                $("#errPassword").show().html("Mật khẩu phải lớn hơn 6 kí tự.");
                ;
                return false;
            } else {
                $("#errPassword").hide().html("");
            }

            if (password != confirmPass) {
                $("#errConfirmPassword").show().html("Mật khẩu không khớp.");
                return false;
            } else $("#errConfirmPassword").hide().html("");
        }
        return true;
    }

    $("#btnRegister").on("click", function (e) {
        e.preventDefault();
        var surname = $("#re-surname").val().trim();
        var name = $("#re-name").val().trim();
        var email = $("#re-email").val().trim();
        var password = $("#re-password").val().trim();
        var confirmPass = $("#re-confirmPassword").val().trim();

        if (!validateInput(surname, name, email, password, confirmPass)) {
            return;
        }
        var data = {
            "surname": surname,
            "name": name,
            "email": email,
            "password": password
        }
        $.ajax({
            url: "/save-user",
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            data: JSON.stringify(data),
            success: function (data) {
                if (data.statusCode == 400) {
                    $("#re-email").parent().append("<small id='errEmail'>" + data.obj + "</small>");
                    return;
                }
                if (data.statusCode == 200) {
                    $("#re-surname").val("");
                    $("#re-name").val("");
                    $("#re-email").val("");
                    $("#re-password").val("");
                    $("#re-confirmPassword").val("");
                    alert(data.obj);
                    window.location.href = "/login";
                }
            },
            error: function (err) {
                console.log(err);
            }
        })
    })

    $("#saveProfile").on("click", function (e) {
        e.preventDefault();
        var id = $("#p-id").val();
        var surname = $("#p-surname").val().trim();
        var name = $("#p-name").val().trim();
        var phone = $("#p-phone").val().trim();
        var email = $("#p-email").val().trim();
        var password = $("#p-password").val().trim();
        var confirmPass = $("#p-confirmPassword").val().trim();


        if (password != '') {
            if (!validateInput(surname, name, email, password, confirmPass)) {
                return;
            }
        }

        if (!validatePhone(phone) && phone != '') {
            $("#errPhone").show().html("Số điện thoại không hợp lệ !");
            return;
        } else $("#errPhone").hide().html("");

        if (!validateInput(surname, name, email, null, null)) {
            return;
        }
        var data = {
            "id": id,
            "surname": surname,
            "phone": phone,
            "name": name,
            "email": email,
            "password": password
        }
        $.ajax({
            url: "/profile/save-profile",
            type: "post",
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            data: JSON.stringify(data),
            success: function (data) {
                if (data.statusCode == 200) {
                    $("#userLogin").html(name);
                    alert(data.obj);
                }
            },
            error: function (err) {
                console.log(err);
            }
        })
    })

    $("#saveAddress").on("click", function (e) {
        e.preventDefault();
        var data = {
            "id": $("#aid").val(),
            "provinceId": $("#province").val(),
            "districtId": $("#district").val(),
            "wardsId": $("#wards").val(),
            "addressDetail": $("#addressDetail").val().trim()
        }

        $.ajax({
            url: "/profile/save-address",
            type: "post",
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            data: JSON.stringify(data),
            success: function (data) {
                alert(data.obj);
            },
            error: function (err) {
                console.log("Lỗi " + err);
            }
        })
    })
})
