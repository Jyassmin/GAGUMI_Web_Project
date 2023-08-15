// alert창 페이지가 완전히 로드된 후 실행
document.addEventListener('DOMContentLoaded', function () {
    // 삭제 링크 요소들을 가져옴
    const deleteLinks = document.querySelectorAll('.delete');

    // 삭제 링크들에 클릭 이벤트 리스너 추가
    deleteLinks.forEach(function (link) {
        link.addEventListener('click', function (event) {
            event.preventDefault(); // 기본 동작(링크 이동) 차단

            // 확인 창 띄우기
            const shouldDelete = confirm('상품을 삭제하시겠습니까?');

            // 사용자가 확인을 눌렀을 경우
            if (shouldDelete) {
                // 삭제 페이지로 이동
                // 여기에 삭제 페이지 URL을 입력해주세요.
                window.location.href = '../seller-home/seller-home.html';
            }
        });
    });
});