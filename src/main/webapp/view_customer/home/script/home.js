/* 클릭 시 submenu 노출*/
// document.addEventListener("DOMContentLoaded", function() {
//     var myPageLink = document.querySelector(".my-page");
//     var submenu = myPageLink.querySelector(".submenu");
//
//     myPageLink.addEventListener("mouseenter", function() {
//         submenu.style.display = "block";
//     });
//
//     myPageLink.addEventListener("mouseleave", function() {
//         submenu.style.display = "none";
//     });
//
//     submenu.addEventListener("mouseenter", function() {
//         submenu.style.display = "block";
//     });
//
//     submenu.addEventListener("mouseleave", function() {
//         submenu.style.display = "none";
//     });
// });


/* home.js */
document.addEventListener("DOMContentLoaded", function() {
    var myPageLink = document.querySelector(".my-page");
    var submenu = myPageLink.querySelector(".submenu");

    myPageLink.addEventListener("mouseenter", function() {
        submenu.style.display = "block";
    });

    myPageLink.addEventListener("mouseleave", function() {
        submenu.style.display = "none";
    });

    submenu.addEventListener("mouseenter", function() {
        submenu.style.display = "block";
    });

    submenu.addEventListener("mouseleave", function() {
        submenu.style.display = "none";
    });
});


// [class & js로 페이지 이동하는 예시]
// document.addEventListener("DOMContentLoaded", function() {
//     const move_login_customer1 = document.querySelectorAll(".move_login_customer");
//
//     // 각 링크에 대해 클릭 이벤트 리스너 등록
//     move_login_customer1.forEach(function(link) {
//         link.addEventListener("click", function(event) {
//             event.preventDefault(); // 기본 동작 방지
//             // 원하는 페이지 주소로 이동
//             window.location.href = "../login/login_customer.jsp";
//         });
//     });
// });


