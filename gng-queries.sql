
#Campaign w/ budget and campaign expenses to date:

select campaign_name, 
budget as total_budget, 
sum(cost) as total_expenses from campaign c
left join expenses e on c.campaign_id = e.campaign_id
group by c.campaign_id;

#Which Members are both volunteers, and are currently engaged with an event:

select m.member_id, v.volunteer_id, m.member_name, e.event_name 
from member m
inner join volunteer v 
on m.member_name = v.volunteer_name
inner join participates p
on v.volunteer_id = p.volunteer_id
inner join event e
on p.event_id = e.event_id;

#All employees directly tasked with securing donations from donors, and their donor contacts:

select e.employee_name, e.position, d.donor_name, d.primary_donor_contact 
from employee e
inner join employs emp
on e.employee_id = emp.employee_id
inner join green_not_greed gng
on emp.gng_id = gng.gng_id
inner join supports s
on gng.gng_id = s.gng_id
inner join donor d
on s.donor_id = d.donor_id;

#All campaign expenses incurred  after August 8th, 2024, and the campaign they were used for:

select c.campaign_name, e.material, e.description, e.cost, e.date_of_purchase 
from expenses e 
join campaign c
on e.campaign_id = c.campaign_id 
where e.date_of_purchase > '2024-08-10';

#All employee names, and their salaries, who were hired after March 5th, 2023 and who earn more that $25000:

select salary, employee_name 
from employee 
where salary > '25000.00' and 
date_hired >= '2023-03-05';

#What materials were both used on campaigns with numeric keys less than 3, 
#and have cost equal to an amount ‘equal to the cost’ of some expense 
#between the date May 10th, 2024 exclusive to May 15th, 2024 inclusive:

select material
from expenses
where campaign_id < 3 and 
cost = (select cost
from expenses 
where date_of_purchase > '2024-05-10' and
date_of_purchase <= '2024-05-15');

#What global affiliates have members that are both members and volunteers of green not greed:

select g.company_name, mem.member_name
from global_affiliate g
join comprises c_mem on g.company_id = c_mem.member_id
join member mem on c_mem.member_id = mem.member_id
where mem.member_name in (
select volunteer_name
from volunteer
intersect
select member_name
from member);

#What campaign events are not fundraiser events:

(select event_name from event)
except all
(select event_name 
from event 
where event_id in (
select event_id
from fundraiser));

#What is the average cost of each material purchased more than once: 

select e.material, avg(cost) as average_cost
from expenses e
group by material
having count(material) >=2;

#What campaigns have not pushed their information to a website yet:

select c.campaign_name
from campaign c
left join represents r on 
c.campaign_id = r.campaign_id
where r.campaign_id is null;
