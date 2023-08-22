﻿-- 사용자 주소 삽입
INSERT INTO user (name, email, pw, phone, gender, birthday, address, zipcode)
VALUES
    ('김영희', 'test', '12341234', '010-1234-5678', 0, '1992-06-25', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,301호, (풍납동)', '00001'),
    ('이철수', 'chulsoo89@naver.com', 'david123', '010-5675-5678', 1, '1989-09-15', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,302호, (풍납동)', '00002'),
    ('박지민', 'jimin98@daum.net', 'emilypass', '010-9879-9876', 0, '1998-02-10', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,303호, (풍납동)', '00003'),
    ('김태영', 'taeyoung85@gmail.com', 'jamespass', '010-5555-1234', 1, '1985-12-01', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,401호, (풍납동)', '00004'),
    ('김지연', 'jiyeon94@naver.com', 'oliviapw', '010-7777-2222', 0, '1994-08-18', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,501호, (풍납동)', '00005'),
    ('이동호', 'dongho91@daum.net', 'will123', '010-8888-3333', 1, '1991-03-30', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,601호, (풍납동)', '00006'),
    ('김미라', 'mira96@gmail.com', 'sophiapass', '010-9999-4444', 0, '1996-11-12', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,602호, (풍납동)', '00007'),
    ('송재민', 'jaemin87@naver.com', 'alex123', '010-4444-5555', 1, '1987-05-20', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,1102호, (풍납동)', '00008'),
    ('박민우', 'minwoo93@daum.net', 'isabellapw', '010-6666-7777', 0, '1993-10-05', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,802호, (풍납동)', '00009');

-- 판매자 주소 삽입
INSERT INTO user (name, role, email, pw, phone, company, address, zipcode)
VALUES
    ('가구마트', 1, 'seller', '12341234', '010-1234-5678', '가구마트 주식회사', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,802호, (풍납동)', '00010'),
    ('홈액센츠', 1, 'accentscontact@naver.com', 'homeaccentspw', '010-3333-4444', '홈액센츠 주식회사', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,902호, (풍납동)', '00011'),
    ('우아한디자인', 1, 'elegantdesigns@daum.net', 'elegant123', '010-5555-6666', '우아한디자인 주식회사', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,202호, (풍납동)', '00012'),
    ('편안한리빙', 1, 'comfortliving@gmail.com', 'comfortpass', '010-7777-8888', '편안한리빙 주식회사', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,102호, (풍납동)', '00013'),
    ('모던인테리어', 1, 'interiorsmodern@naver.com', 'modern123', '010-9999-0000', '모던인테리어 주식회사', '서울 송파구 바람드리길 2,서울 송파구 풍납동 124-5,702호, (풍납동)', '00014');

INSERT INTO category1 (ca1_name)
VALUES
    ('의자'),
    ('소파'),
    ('서랍/수납장'),
    ('테이블'),
    ('침대'),
    ('장롱');

INSERT INTO category2 (ca1id, ca2_name)
VALUES
    (1, '스툴'),
    (1, '화장대 의자'),
    (2, '소'),
    (2, '중'),
    (2, '대'),
    (3, '서랍'),
    (3, '수납장'),
    (4, '책상'),
    (4, '식탁'),
    (5, '침대'),
    (6, '장롱');

INSERT INTO product (uid, ca2id, name, stock, cost, `desc`, pimage, size)
VALUES
    -- 의자
    (10, 1, '우아한 식탁의자', 20, 100000, '식탁을 더욱 우아하게 만들어주는 식탁의자입니다.', '../../images/chair1.jpg', '중형'),
    (11, 1, '모던한 스툴', 15, 120000, '모던한 디자인의 스툴로 다용도로 사용할 수 있습니다.', '../../images/chair2.jpg', '소형'),
    (12, 1, '클래식한 나무 의자', 10, 110000, '클래식한 디자인의 나무 의자입니다.', '../../images/chair3.jpg', '중형'),
    (13, 1, '모던 원형 의자', 8, 130000, '모던한 원형 디자인의 의자입니다.', '../../images/chair4.jpg', '소형'),
    (13, 1, '심플한 플라스틱 의자', 12, 95000, '심플한 디자인의 플라스틱 의자입니다.','../../images/chair5.jpg', '소형'),
    (14, 2, '깔끔한 화장대', 12, 145000, '깔끔한 디자인의 화장대입니다.', '../../images/chair6.jpg', '소형'),
    (14, 2, '원목 나무 화장대', 12, 200000, '원목으로 만든 나무 화장대입니다.', '../../images/chair7.jpg', '소형'),

    -- 소파
    (10, 3, '소형 소파', 8, 150000, '작지만 편안한 소형 소파입니다.', '../../images/sofa1.jpg', '소형'),
    (11, 4, '중형 소파', 5, 180000, '편안한 중형 소파로 가족과 함께 시간을 보내보세요.', '../../images/sofa2.jpg', '중형'),
    (12, 5, '큰 소파', 3, 220000, '큰 공간을 채울 수 있는 편안한 큰 소파입니다.', '../../images/sofa3.jpg', '대형'),
    (13, 5, '모던한 소파', 6, 190000, '모던한 디자인의 소파로 공간을 더욱 화사하게 만들어줍니다.', '../../images/sofa4.jpg', '중형'),
    (14, 5, '코지 침대 소파', 9, 210000, '편안한 코지 침대 소파로 여유로운 시간을 즐겨보세요.', '../../images/sofa5.jpg', '중형'),

    -- 서랍/수납장
    (10, 6, '다용도 서랍', 10, 120000, '다양한 물건을 수납할 수 있는 다용도 서랍입니다.', '../../images/drawer1.jpg', '중형'),
    (12, 6, '큰 서랍', 5, 150000, '다양한 물건을 넣을 수 있는 큰 서랍입니다.', '../../images/drawer2.jpg', '대형'),
    (13, 6, '파일 서랍', 7, 110000, '파일과 문서를 정리할 수 있는 서랍입니다.', '../../images/drawer3.jpg', '중형'),
    (11, 7, '작은 수납장', 6, 90000, '작지만 유용한 작은 수납장입니다.', '../../images/drawer4.jpg', '소형'),
    (14, 7, '고급 나무 수납장', 4, 180000, '고급스러운 나무 수납장으로 공간을 더욱 화사하게 만들어줍니다.', '../../images/drawer5.jpg', '중형'),

    -- 테이블
    (10, 8, '편안한 책상', 8, 140000, '편안하게 공부하거나 일할 수 있는 책상입니다.', '../../images/desk1.jpg', '중형'),
    (11, 8, '큰 책상', 6, 160000, '다양한 물건을 놓을 수 있는 큰 책상입니다.', '../../images/desk2.jpg', '대형'),
    (12, 9, '큰 식탁', 5, 220000, '다양한 사람들과 함께 식사를 할 수 있는 큰 식탁입니다.', '../../images/desk3.jpg', '대형'),
    (13, 9, '파티용 테이블', 4, 250000, '파티나 모임에 적합한 큰 테이블입니다.', '../../images/desk4.jpg', '대형'),
    (14, 9, '다용도 접이식 테이블', 7, 180000, '다용도로 사용할 수 있는 편리한 접이식 테이블입니다.', '../../images/desk5.jpg', '중형'),

    -- 침대
    (10, 10, '편안한 침대', 10, 280000, '편안하게 잠을 청할 수 있는 편안한 침대입니다.', '../../images/bed1.jpg', '킹사이즈'),
    (11, 10, '큰 침대', 6, 320000, '공간을 편안하게 채우는 큰 침대입니다.', '../../images/bed2.jpg', '퀸사이즈'),
    (12, 10, '모던한 침대', 8, 270000, '모던한 디자인의 침대로 공간을 더욱 화사하게 만들어줍니다.', '../../images/bed4.jpg', '퀸사이즈'),
    (13, 10, '고급스러운 침대', 5, 350000, '고급스러운 느낌의 침대입니다.', '../../images/bed5.jpg', '킹사이즈'),

    -- 장롱
    (10, 11, '수납이 넓은 장롱', 12, 240000, '작은 공간에도 적합한 수납이 넓은 장롱입니다.', '../../images/closet1.jpg', '중형'),
    (14, 11, '나무 원목 장롱', 20, 340000, '나무 원목으로 만든 장롱입니다.', '../../images/closet2.jpg', '대형');

INSERT INTO shoppingcart (uid, pid, quantity)
VALUES
    (1, 1, 2),
    (1, 5, 1),
    (1, 12, 3),
    (2, 3, 3),
    (2, 13, 2),
    (3, 7, 2),
    (3, 10, 1),
    (3, 14, 1),
    (4, 2, 4),
    (4, 15, 4),
    (5, 8, 2),
    (5, 16, 2),
    (6, 4, 1),
    (6, 17, 3),
    (7, 6, 3),
    (7, 18, 1),
    (8, 9, 2),
    (8, 19, 2),
    (9, 11, 1),
    (9, 20, 1);


INSERT INTO history (uid, pid, oid, quantity, pname, cost, datetime)
VALUES
    -- uid 1
    (1, 1, 1, 2, '우아한 식탁의자', 200000, '2023-08-01 10:15:00'),
    (1, 5, 1, 1, '심플한 플라스틱 의자', 95000, '2023-08-01 10:15:00'),
    (1, 12, 1, 3, '클래식한 나무 의자', 360000, '2023-08-01 10:15:00'),
    (1, 8, 2, 1, '중형 소파', 180000, '2023-08-02 13:30:00'),
    (1, 3, 3, 2, '편안한 책상', 200000, '2023-08-03 09:45:00'),
    (1, 10, 3, 2, '큰 소파', 440000, '2023-08-03 09:45:00'),
    (1, 15, 4, 3, '모던한 소파', 420000, '2023-08-04 12:30:00'),
    (1, 6, 5, 2, '큰 서랍', 180000, '2023-08-05 15:30:00'),
    (1, 17, 6, 1, '수납이 넓은 장롱', 290000, '2023-08-06 11:10:00'),
    (1, 2, 7, 2, '모던한 스툴', 320000, '2023-08-07 09:20:00'),

    -- uid 2
    (2, 3, 2, 3, '큰 소파', 810000, '2023-08-02 09:45:00'),
    (2, 13, 2, 2, '다용도 접이식 테이블', 540000, '2023-08-02 09:45:00'),
    (2, 3, 3, 1, '큰 소파', 270000, '2023-08-03 16:00:00'),

    -- uid 3
    (3, 7, 4, 2, '작은 수납장', 290000, '2023-08-04 12:30:00'),
    (3, 10, 5, 1, '큰 소파', 220000, '2023-08-05 13:40:00'),
    (3, 14, 5, 1, '다용도 접이식 테이블', 150000, '2023-08-05 13:40:00'),

    -- 추가 데이터
    (7, 11, 6, 2, '편안한 침대', 480000, '2023-08-06 16:00:00'),
    (1, 9, 7, 1, '큰 책상', 200000, '2023-08-07 10:30:00'),

    -- uid 4
    (4, 2, 8, 4, '모던한 스툴', 480000, '2023-08-08 14:50:00'),
    (4, 15, 8, 4, '고급스러운 침대', 1400000, '2023-08-08 14:50:00'),
    (4, 2, 9, 4, '모던한 스툴', 480000, '2023-08-09 11:25:00'),

    -- uid 5
    (5, 8, 10, 2, '큰 소파', 360000, '2023-08-10 15:45:00'),
    (5, 16, 11, 2, '큰 소파', 360000, '2023-08-11 11:00:00'),
    (5, 8, 11, 2, '큰 소파', 360000, '2023-08-11 11:00:00'),

    -- uid 6
    (6, 4, 12, 1, '중형 소파', 130000, '2023-08-12 09:30:00'),
    (6, 15, 12, 3, '고급스러운 침대', 435000, '2023-08-12 09:30:00'),
    (6, 14, 12, 3, '다용도 접이식 테이블', 435000, '2023-08-12 09:30:00'),

    -- uid 7
    (7, 6, 13, 3, '편안한 책상', 435000, '2023-08-13 14:50:00'),
    (7, 16, 13, 1, '심플한 플라스틱 의자', 180000, '2023-08-13 14:50:00'),
    (7, 2, 13, 1, '모던한 스툴', 180000, '2023-08-13 14:50:00'),

    -- uid 8
    (8, 9, 14, 2, '큰 책상', 400000, '2023-08-14 15:30:00'),
    (8, 4, 14, 2, '중형 소파', 360000, '2023-08-14 15:30:00'),
    (8, 9, 14, 2, '큰 책상', 400000, '2023-08-14 15:30:00'),

    -- uid 9
    (9, 11, 15, 1, '큰 소파', 240000, '2023-08-15 10:30:00'),
    (9, 15, 15, 1, '심플한 플라스틱 의자', 180000, '2023-08-15 10:30:00'),
    (9, 13, 15, 1, '다용도 접이식 테이블', 180000, '2023-08-15 10:30:00');


INSERT INTO review (hid, title, `text`, datetime, `like`)
VALUES
    (1, '좋은 제품', '좋은 품질의 의자입니다. 디자인도 마음에 들어요.', '2023-08-01 10:30:00', 0),
    (4, '매우 만족', '정말 만족스러운 소파예요! 편안하고 고급스러워요.', '2023-08-02 15:20:00', 28),
    (7, '조립이 어려워요', '가격 대비 성능은 그럭저럭입니다. 조립이 어려웠어요.', '2023-08-03 09:50:00', 6),
    (10, '만족스러워요', '이 가격에 이렇게 좋은 침대를 구매할 수 있다니 감사해요!', '2023-08-04 11:00:00', 34),
    (13, '예뻐요', '탁자에 딱 맞는 의자입니다. 디자인도 예뻐요.', '2023-08-05 14:30:00', 15),
    (16, '만족하지만...', '화장대의 마감이 조금 아쉽지만 기능은 잘 해요.', '2023-08-06 13:15:00', 9),
    (19, '놀랍네요', '이 가격에 이렇게 퀄리티 좋은 서랍장을 구매할 수 있다니 놀랍네요!', '2023-08-07 16:45:00', 22),
    (22, '고급스러워요', '고급스러운 책상이에요. 일하기에도 좋아요.', '2023-08-08 10:10:00', 18),
    (23, '중량감 있지만 품질 좋아요', '다소 중량감이 있지만 품질은 좋아요.', '2023-08-09 12:30:00', 7),
    (24, '마음에 들어요', '저렴한 가격에 만족스러운 의자를 구매했어요!', '2023-08-10 09:20:00', 31),
    (25, '별로에요', '아무리 싸도 이 정도면 아까워요. 별로에요.', '2023-08-11 11:45:00', 3),
    (26, '가격이 조금 아쉬워요', '디자인도 편안도 좋아요. 다만 가격이 조금 아쉬워요.', '2023-08-12 14:30:00', 16),
    (27, '매우 만족해요', '매우 만족해요! 품질이 훌륭하고 배송도 빠르게 왔어요.', '2023-08-13 16:10:00', 42),
    (28, '그럭저럭', '의자의 완성도가 조금 아쉬워요. 가격대비 그럭저럭입니다.', '2023-08-14 09:50:00', 10),
    (29, '만족합니다', '화장대 디자인이 마음에 들어요. 공간 활용도 좋아요.', '2023-08-15 12:20:00', 24),
    (30, '서랍장 퀄리티 좋아요', '서랍장 퀄리티가 높아서 만족해요. 조립이 쉬웠어요.', '2023-08-16 15:30:00', 19),
    (31, '조립이 복잡해요', '테이블은 좋은데 조립이 복잡해서 어려웠어요.', '2023-08-17 11:10:00', 8),
    (32, '마음에 들어요', '마음에 드는 침대였어요. 조립이 어렵긴 했지만요.', '2023-08-18 11:40:00', 21);

INSERT INTO comment (rid, uid, text, datetime, like_yn)
VALUES
    (1, 9, '이 제품을 구매하면 어떤 배송 서비스를 제공하나요?', '2023-08-01 09:30:00', 0),
    (1, 6, '배송은 빠르고 안전하게 이루어집니다. 구매 후 2~3일 이내에 도착할 수 있도록 노력하고 있어요.', '2023-08-01 10:00:00', 1),
    (2, 2, '이 소파의 소재가 뭐에요? 플라스틱 같은 느낌이 나나요?', '2023-08-02 14:20:00', 0),
    (2, 6, '아니요, 이 소파의 소재는 천연 가죽을 사용하여 편안하면서도 고급스러운 느낌을 줍니다.', '2023-08-02 15:00:00', 1),
    (3, 4, '장롱의 크기가 얼마나 되나요? 한 번 확인해보고 결정하고 싶어서요.', '2023-08-03 11:45:00', 0),
    (3, 8, '이 장롱은 가로 180cm, 세로 220cm 정도의 크기로 제작되었습니다. 공간을 활용하기 좋아요.', '2023-08-03 12:30:00', 1),
    (4, 5, '편안한 플라스틱 의자는 무엇으로 만들어져 있나요? 부드럽게 느껴지나요?', '2023-08-04 13:10:00', 0),
    (4, 2, '편안한 플라스틱 의자는 고밀도 폴리에틸렌을 사용하여 만들어졌어요. 부드럽고 편안한 디자인입니다.', '2023-08-04 14:00:00', 1),
    (5, 7, '이 식탁은 어떤 나무로 만들어져 있나요? 내구성이 좋아보이네요.', '2023-08-05 10:25:00', 0),
    (5, 1, '이 식탁은 소나무 원목을 사용하여 제작되었습니다. 튼튼하면서도 자연스러운 느낌을 줍니다.', '2023-08-05 11:15:00', 1),
    (6, 3, '큰 소파는 어떤 컬러로 구매할 수 있나요? 집에 어울리는 컬러를 찾고 있어요.', '2023-08-06 09:50:00', 0),
    (6, 7, '큰 소파는 다양한 컬러 중에서 베이지와 그레이를 선택할 수 있습니다. 두 컬러 모두 집에 잘 어울릴 거예요.', '2023-08-06 10:30:00', 1),
    (7, 4, '이 작은 수납장은 세부적인 사이즈가 어떻게 되나요? 한 번 확인해보려고 해요.', '2023-08-07 12:00:00', 0),
    (7, 2, '이 작은 수납장의 크기는 가로 60cm, 세로 40cm, 높이 80cm 정도입니다. 작지만 유용한 제품이에요.', '2023-08-07 12:30:00', 1),
    (8, 8, '작은 책상은 어떤 재질로 만들어져 있나요? 튼튼한 제품인지 궁금합니다.', '2023-08-08 14:20:00', 0),
    (8, 3, '작은 책상은 강화 유리와 강철 소재를 사용하여 제작되었습니다. 안정적이고 견고한 구조입니다.', '2023-08-08 15:00:00', 1),
    (9, 1, '이 침대의 사이즈는 어떻게 되나요? 퀸 사이즈보다 더 큰 킹 사이즈도 제공되나요?', '2023-08-09 11:45:00', 0),
    (9, 6, '이 침대는 퀸 사이즈와 킹 사이즈 두 가지 옵션으로 제공됩니다. 필요한 사이즈를 선택하세요!', '2023-08-09 12:30:00', 1),
    (10, 9, '이 책장은 어떤 공간에 놓기에 적합한 사이즈인가요? 방이 작은데 딱 맞는 크기가 필요해요.', '2023-08-10 09:50:00', 0),
    (10, 4, '이 책장의 크기는 가로 80cm, 세로 180cm 정도로 작지만 수납 공간이 충분합니다. 작은 방에도 잘 어울려요.', '2023-08-10 10:30:00', 1),
    (11, 7, '이 침대는 어떤 체형에 맞춰서 선택하는 것이 좋아요? 편안한 수면을 위해서는 어떤 점을 고려해야 하나요?', '2023-08-11 12:00:00', 0),
    (11, 1, '침대 선택 시 체형뿐만 아니라 자신이 원하는 편안한 느낌도 중요합니다. 침대의 편안함이 좋은 수면을 만듭니다.', '2023-08-11 12:30:00', 1),
    (12, 3, '큰 식탁의 가격대는 어떻게 되나요? 예산을 고려하고 있어서 여쭤봅니다.', '2023-08-12 14:20:00', 0),
    (12, 8, '큰 식탁은 300만 원부터 800만 원 사이의 가격대로 다양한 옵션이 준비되어 있습니다. 예산에 맞춰 선택하세요.', '2023-08-12 15:00:00', 1),
    (13, 5, '이 책상은 어떤 작업 공간에 적합한가요? 홈 오피스용으로 사용하기 좋을까요?', '2023-08-13 11:45:00', 0),
    (13, 2, '이 책상은 홈 오피스나 작업 공간에 딱 맞는 크기로 제작되었습니다. 효율적인 작업 환경을 위해 추천해요.', '2023-08-13 12:30:00', 1),
    (14, 1, '이 소파는 어떤 재질로 만들어져 있는 건가요? 가죽 소재인가요?', '2023-08-14 09:50:00', 0),
    (14, 6, '이 소파는 천연 가죽 소재로 제작되었습니다. 편안한 재질로 고급스러운 분위기를 연출합니다.', '2023-08-14 10:30:00', 1),
    (15, 2, '큰 수납장은 어떤 공간에 배치하는 게 좋아요? 거실이나 침실 중 어디에 놓으면 유용할까요?', '2023-08-15 12:00:00', 0),
    (15, 7, '큰 수납장은 주로 거실이나 침실에 놓으면 좋습니다. 다양한 물건을 정리하고 수납할 수 있는 제품이에요.', '2023-08-15 12:30:00', 1),
    (16, 4, '이 의자는 몇 개 세트로 판매되나요? 다량 구매할 때 할인 혜택이 있을까요?', '2023-08-16 14:20:00', 0),
    (16, 9, '이 의자는 보통 4개 세트로 판매되며, 다량 구매 시에는 일정한 할인 혜택을 제공하고 있습니다.', '2023-08-16 15:00:00', 1),
    (17, 6, '이 작은 수납장은 어떤 컬러로 구매할 수 있나요? 화이트 옵션이 있을까요?', '2023-08-17 11:45:00', 0),
    (17, 1, '이 작은 수납장은 화이트와 월넛 두 가지 컬러 옵션으로 제공됩니다. 화이트는 깔끔한 느낌을 줄 것입니다.', '2023-08-17 12:30:00', 1),
    (18, 3, '작은 소파의 구매를 고려 중인데, 어떤 컬러가 가장 인기 있나요? 집에 잘 어울리는 컬러를 고르고 싶습니다.', '2023-08-18 14:20:00', 0),
    (18, 8, '작은 소파는 그레이와 블루 컬러가 인기 있습니다. 어떤 컬러도 집에 잘 어울릴 것입니다.', '2023-08-18 15:00:00', 1);
