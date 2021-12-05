/*Query 1: What is the relationship between police units and the number of allegations? */
Select POLICE_UNIT, COUNT_ALLEGATIONS, total_officers, TRUNC((COUNT_ALLEGATIONS :: numeric / total_officers),2) as allegation_ratio_per_unit  from
(select b.last_unit_id AS POLICE_UNIT, count(a.officer_id) AS COUNT_ALLEGATIONS from data_officerallegation a
join data_officer b
on a.officer_id = b.id
group by b.last_unit_id
order by count(a.officer_id) desc)A

Inner join

(Select count(id) as total_officers, last_unit_id from data_officer group by last_unit_id order by  last_unit_id)B

on A.POLICE_UNIT = B.last_unit_id order by allegation_ratio_per_unit desc


/* Query 2: What is the relation between the rank of the officer and the number of complaints against him/her and number of complaints sustained? */

/* PART A */
select a.id, a.first_name, a.last_name, a.rank, count(b.officer_id) as total_allegations,
   	count(CASE WHEN b.disciplined = True THEN b.officer_id END) as sustained_allegations from data_officer a
join data_officerallegation b
on a.id = b.officer_id
group by a.id
order by count(b.officer_id) desc;

/* PART B */
SELECT rank, sum(total_allegations) as Total_allegations, sum(sustained_allegations) as Sustained_Allegations, ROUND(sum(sustained_allegations) * 100 /sum(total_allegations),2) as percent
       from (select a.id, a.first_name, a.last_name, a.rank, count(b.officer_id) as total_allegations,
   	count(CASE WHEN b.disciplined = True THEN b.officer_id END) as sustained_allegations from data_officer a
join data_officerallegation b
on a.id = b.officer_id
group by a.id
order by count(b.officer_id) desc)A group by rank order by percent desc;


/* Query 3: What is the relation between the race of the police officers and and the number of complaints against him/her and number of complaints sustained? */

/* PART A */
select a.id, a.first_name, a.last_name, a.race, count(b.officer_id) as total_allegations,
   	count(CASE WHEN b.disciplined = True THEN b.officer_id END) as sustained_allegations from data_officer a
join data_officerallegation b
on a.id = b.officer_id
group by a.id
order by count(b.officer_id) desc;

/* PART B */
SELECT race, sum(total_allegations) as Total_allegations, sum(sustained_allegations) as Sustained_Allegations, ROUND(sum(sustained_allegations) * 100 /sum(total_allegations),2) as percent
       from (select a.id, a.first_name, a.last_name, a.race, count(b.officer_id) as total_allegations,
   	count(CASE WHEN b.disciplined = True THEN b.officer_id END) as sustained_allegations from data_officer a
join data_officerallegation b
on a.id = b.officer_id
group by a.id
order by count(b.officer_id) desc)A group by race order by total_allegations desc ;


/* Query 4: What is the maximum occurring category for the allegations against a police officer? */

/* PART A */
select c.first_name, c.last_name, c.rank, count(b.officer_id) as total_allegations, max(a.category) as most_common_category
from data_allegationcategory a
join data_officerallegation b
on a.id = b.allegation_category_id
join data_officer c
on c.id = b.officer_id
group by c.id
order by count(b.officer_id) desc;

/* PART B */
select a.category, count(allegation_category_id) as total_allegations from data_allegationcategory a
join data_officerallegation b
on a.id = b.allegation_category_id
group by a.category
order by count(allegation_category_id) desc;

