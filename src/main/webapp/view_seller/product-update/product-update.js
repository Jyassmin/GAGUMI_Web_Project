// 상품 이미지 변경을 위한 토글 기능
const productImg = document.getElementById('productImg');
const modifyImgInput = document.getElementById('modify_img');


productImg.addEventListener('click', function () {
    // 파일 업로드(input) 태그의 가시성을 토글
    if (modifyImgInput.style.display === 'none' || modifyImgInput.style.display === '') {
        modifyImgInput.style.display = 'block';
    } else {
        modifyImgInput.style.display = 'none';
    }
});

// 파일 업로드(input) 태그가 변경될 때 이미지(src)를 input에 넣기
modifyImgInput.addEventListener('change', function () {
    const fileInput = modifyImgInput.files[0]; // 선택된 파일 가져오기
    if (fileInput) {
        const reader = new FileReader();

        reader.onload = function (e) {
            // 이미지를 읽어와서 이미지(src) 업데이트
            productImg.src = e.target.result;
        };

        reader.readAsDataURL(fileInput);
    }
});

