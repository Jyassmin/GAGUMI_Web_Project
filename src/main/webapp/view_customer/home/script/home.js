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
