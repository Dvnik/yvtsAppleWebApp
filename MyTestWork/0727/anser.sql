-- 3、查詢 books 資料表中書籍名稱與價格如下圖
SELECT 書籍名稱, 價格 FROM `books` WHERE 1
-- 4、books 資料表中，利用別名讓欄位變成英文
SELECT 書籍名稱 AS Title, 價格 AS Price FROM `books` WHERE 1
-- 5、books 資料表中有一個價格欄位， 折扣價為「價格 *0.8」
SELECT 書籍名稱, (價格 * 0.8) AS 折扣價 FROM `books` WHERE 1
-- 6、若想要從 employee 資料表中，找出所有女性員工 的資料
SELECT * FROM `employee` WHERE 性別='女'
-- 7、從 books 資料表中，查詢價格小於 360 或大於等於 500 的書籍
SELECT * FROM `books` WHERE 價格 < 360 OR 價格 >= 500
-- 8、從 books 資料表中，依照價格欄位，由大到小排序 書籍
SELECT * FROM `books` ORDER BY 價格 DESC
-- 9、從 books 資料表中，依照價格高至低排列，找出最 高的 5 本書
SELECT * FROM `books` ORDER BY 價格 DESC LIMIT 5
--10、想要從 books 與 employee 資料表中，找出所有書 籍及其負責人資料
SELECT * FROM `books` JOIN `employee` ON `books`.`負責員工編號` = `employee`.`員工編號`
