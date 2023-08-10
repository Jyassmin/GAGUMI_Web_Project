$(document).ready(function() {
    // 탭 클릭 시 배경색 레드 , 글자 화이트 처리
    $('.navmenu > li > a').click(function() {
        $('.navmenu > li').removeClass('active');
        $(this).parent().addClass('active');
    });
});