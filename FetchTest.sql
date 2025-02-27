/* Looking at the data I find the 'Z' at the end of all the timestamps weird, as well as some quantities being written out as "zero" instead of just "0". Quite a few blank spaces as well. 
As I dug deeper, it appears that you have many user ids but not nearly as many transactions to link them to.
*/
select *
from products;
select *
from transactions;
select *
from users;

/* Closed-Ended Question 1: Looks like the top brands are Dove, Sour Patch Kids, and a tie between Coca-cola, Great Value, Hershey's, Meijer, and Nerds Candy.
*/

select distinct c.BRAND, count(c.BRAND)
from users a 
inner join transactions b 
on a.ID = b.USER_ID
left join products c
on b.BARCODE = c.BARCODE
where substring(a.BIRTH_DATE, 1, 10) <= '2004-02-20' and b.BARCODE <> '' and c.brand <> '' and b.final_quantity <> 'zero' --To remove some bad data, like we don't want 0 purchases to be apart of this.
group by c.BRAND;

/* Open-ended Question 2: Not sure why this question is here as you can point to Tostitos as the leading brand as it has the most sales overall. We could add a simple additional where statement
if you wish to drill down by year or month, if by 'leading' you were looking for something more along the lines of most growing brand. 
*/
select distinct c.CATEGORY_2, c.BRAND, sum(b.FINAL_SALE) as FINAL_SALE_TOTAL
from transactions b
left join products c
on b.BARCODE = c.BARCODE
where c.CATEGORY_2 like 'Dips & Salsa' and b.BARCODE <> '' and c.brand <> ''
group by c.brand;

/* Open-ended Question 1: There are a couple ways to look at this question but I chose to point to specific users. The data provided has a few top spends, most being female.
It would be rather easy to drill down further to answer more specific questions like "which state spends the most" or "which gender spends the most".
*/

select distinct a.ID, a.STATE, a.GENDER, sum(b.FINAL_SALE)
from users a 
inner join transactions b 
on a.ID = b.USER_ID
group by a.ID;

/* 
        Hello key stakeholders,
        
        The data provided holds just as many insights in its data as it does questions in its quality. It has come to my attention that there are some issues that need addressing
        like why our data is writing out the word "zero" instead of using just the number "0" or why we have significantly more users than we do receipts to match them with. Despite
        these issues we do have plenty of insights to look on. With the available data, we can conclude that only our 7 top spenders have purchased more than 20 dollars through
        the Fetch service, and that 6/7 of them are female. Infact, of the people spending money through our service, 15 are men and 75 are women. It may be worth our time and effort 
        to try to better balance these numbers. Also, If possible, it would be nice to get access to the underlying code that gathers this data so that we can see about tackling these data
        issues.
*/