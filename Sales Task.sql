---------------------CODE-------------------------------

WITH T1 AS (SELECT CUSTOMERNAME, B.baldate, balance, ACCOUNTTYPE = 'Bond',
		ROW_NUMBER() OVER (PARTITION BY CUSTOMERNAME ORDER BY BALDATE DESC) ROWSS
FROM customer_table CU
JOIN BONDBALANCE B
ON CU.ID = B.custid
UNION ALL 
SELECT CUSTOMERNAME, CB.baldate, balance, ACCOUNTTYPE = 'CreditCard',
		ROW_NUMBER() OVER (PARTITION BY CUSTOMERNAME ORDER BY BALDATE DESC) ROWSS	
FROM customer_table CU
JOIN creditcardbalance CB
ON CU.ID = CB.custid)
SELECT CUSTOMERNAME, BALDATE, BALANCE, ACCOUNTTYPE
FROM T1
WHERE ROWSS = 1 
ORDER BY customername, ACCOUNTTYPE
