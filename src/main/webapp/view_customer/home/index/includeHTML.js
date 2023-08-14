function includeHTML(callback) {
    var z, i, elmnt, file, xhr;
    /*loop through a collection of all HTML elements:*/
    z = document.getElementsByTagName("*");
    for (i = 0; i < z.length; i++) {
        elmnt = z[i];
        /*search for elements with a certain atrribute:*/
        file = elmnt.getAttribute("include-html");
        //console.log(file);
        if (file) {
            /*make an HTTP request using the attribute value as the file name:*/
            xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (this.readyState == 4) {
                    if (this.status == 200) {
                        elmnt.innerHTML = this.responseText;
                    }
                    if (this.status == 404) {
                        elmnt.innerHTML = "Page not found.";
                    }
                    /*remove the attribute, and call this function once more:*/
                    elmnt.removeAttribute("include-html");
                    includeHTML(callback);
                }
            };
            xhr.open("GET", file, true);
            xhr.send();
            /*exit the function:*/
            return;
        }
    }
    setTimeout(function() {
        callback();
    }, 0);
}

/* 클릭 시 submenu 노출*/
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

