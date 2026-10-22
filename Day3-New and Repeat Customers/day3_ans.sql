create table customer_orders (
	order_id integer,
	customer_id integer,
	order_date date,
	order_amount integer
);

insert into customer_orders values
	(1,100,cast('2022-01-01' as date),2000),
	(2,200,cast('2022-01-01' as date),2500),
	(3,300,cast('2022-01-01' as date),2100),
	(4,100,cast('2022-01-02' as date),2000),
	(5,400,cast('2022-01-02' as date),2200),
	(6,500,cast('2022-01-02' as date),2700),
	(7,100,cast('2022-01-03' as date),3000),
	(8,400,cast('2022-01-03' as date),1000),
	(9,600,cast('2022-01-03' as date),3000);

select * from customer_orders;

---------------------------------option1---------------------------------
with cte_fist_visit as 
	(
	  select
		customer_id, 
		min(order_date) as first_visit_date
	  from customer_orders
	  group by customer_id
	)
	
select  
  c.order_date, 
  sum(case when c.order_date = f.first_visit_date then 1 else 0 end) as new_customers,
  sum(case when c.order_date != f.first_visit_date then 1 else 0 end) as repeat_customers
from 
  customer_orders c
inner join cte_fist_visit f
on c.customer_id = f.customer_id
group by c.order_date;

---------------------------------option 2---------------------------------
select  
	  order_date, 
	  sum(case when order_date = first_visit_date then 1 else 0 end) as new_customers,
	  sum(case when order_date != first_visit_date then 1 else 0 end) as repeat_customers
from 
	(
		select 
		  order_id, 
		  customer_id, 
		  order_date,
		  min(order_date) over(partition by customer_id )as first_visit_date
		from 
		customer_orders  
	) t
group by order_date

