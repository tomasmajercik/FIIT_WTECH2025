insert into
	users (
		first_name,
		last_name,
		email,
		password,
		phone,
		role
	)
values(
		'John',
		'Doe',
		'john.doe@example.com',
		'$2a$10$abcdefghijklmnopqrstuvwxyz1234567890',
		'123-456-7890',
		'user'
);
select * from users;

insert into
	addresses (
		city,
		postal_code,
		country,
		address_line1,
		address_line2
	)
values(
		'Bratislava',
		'811 01',
		'Slovakia',
		'Hlavná 123',
		null
);
select * from addresses;

insert into
	user_address (user_id, address_id, is_default)
values(
	(
		select
			id
		from
			users
		where
			email = 'john.doe@example.com'
	),
	(
		select
			id
		from
			addresses
		where
			city = 'Bratislava'
	),
	true
);
select * from user_address;

select * from products;







	