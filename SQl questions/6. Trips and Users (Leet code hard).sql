--6. Trips and users

-- Table structure : 
-- trips and users

-- link : https://leetcode.com/problems/trips-and-users/

/*
The cancellation rate is computed by dividing the number of canceled (by client or driver) 
requests with unbanned users by the total number of requests with unbanned users on that day.
Write a SQL query to find the cancellation rate of requests with unbanned users 
(both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". 
Round Cancellation Rate to two decimal points.

Output: 
+------------+-------------------+
| Day        | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0.00              |
| 2013-10-03 | 0.50              |
+------------+-------------------+

Explanation: 
On 2013-10-01:
  - There were 4 requests in total, 2 of which were canceled.
  - However, the request with Id=2 was made by a banned client (User_Id=2), so it is ignored in the calculation.
  - Hence there are 3 unbanned requests in total, 1 of which was canceled.
  - The Cancellation Rate is (1 / 3) = 0.33
On 2013-10-02:
  - There were 3 requests in total, 0 of which were canceled.
  - The request with Id=6 was made by a banned client, so it is ignored.
  - Hence there are 2 unbanned requests in total, 0 of which were canceled.
  - The Cancellation Rate is (0 / 2) = 0.00
On 2013-10-03:
  - There were 3 requests in total, 1 of which was canceled.
  - The request with Id=8 was made by a banned client, so it is ignored.
  - Hence there are 2 unbanned request in total, 1 of which were canceled.
  - The Cancellation Rate is (1 / 2) = 0.50
*/

with t1 as (
select request_at,
       count(case when role = 'client' then 1 else null end) total_requests,
	   count(case when role = 'client' and status like '%cancelled%' then 1 else null end) as total_cancelled
from users as u 
join trips as t 
on u.users_id = t.client_id or u.users_id = t.driver_id
where u.banned = 'No' and 
      request_at between  '2013-10-01' and '2013-10-03'
group by 1
)
select request_at, round(1.0*total_cancelled/total_requests,2) as cancellation_rate
from t1


