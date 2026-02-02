drop table if exists employee_log;
drop table if exists employees;

create table employees (
    emp_id serial primary key,
    name varchar(50),
    position varchar(50)
);

create table employee_log (
    log_id serial primary key,
    emp_name varchar(50),
    action_time timestamp
);

create or replace function log_employee_update()
returns trigger
as $$
begin
    insert into employee_log(emp_name, action_time)
    values (new.name, now());

    return new;
end;
$$ language plpgsql;

create trigger trg_log_employee_update
after update on employees
for each row
execute function log_employee_update();

insert into employees(name, position) values
('nguyen van a', 'developer'),
('tran thi b', 'tester'),
('le van c', 'manager');

update employees
set position = 'senior developer'
where emp_id = 1;

update employees
set name = 'tran thi b updated'
where emp_id = 2;

select * from employee_log;
