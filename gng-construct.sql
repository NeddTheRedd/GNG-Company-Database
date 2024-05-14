#Table Creations (Entity Sets):

create table green_not_greed (
    gng_id serial primary key,
    gng_name varchar(255),
    gng_email varchar(255),
    gng_phone varchar(15)
);

insert into green_not_greed (gng_name, gng_email, gng_phone) values
    ('green not greed organization', 'info@greennotgreed.org', '123-456-7890'),
    ('green not greed organization', 'generalenquiries@greennotgreed.org', '999-999-9999'),
    ('green not greed organization', 'emergency@greennotgreed.org', '911-911-9111'),
    ('green not greed organization', 'donor_support@greennotgreed.org', '987-654-3333'),
    ('green not greed organization', 'members_official@greennotgreed.org', '987-654-8888');


create table global_affiliate (
    company_id serial primary key,
    company_name varchar(255),
    company_location varchar(255),
    company_phone varchar(15),
    company_email varchar(255)
);

insert into global_affiliate (company_name, company_location, company_phone, company_email) values
    ('abc corporation', 'los angeles', '987-654-3210', 'john@abc.com'),
    ('thugs not rugs', 'nanaimo', '764-255-8769', 'june@rugs.com'),
    ('thugs not rugs', 'duncan', '929-255-8769', 'beanie@rugs.com'),
    ('thugs not rugs', 'victoria', '250-255-8769', 'gurwinder@rugs.com'),
    ('currs n furs', 'fort mcneil', '604-888-8888', 'wolfy@currrrrr.com'),
    ('currs n furs', 'yukon', '753-888-8888', 'bigbear@currrrrr.com'),
    ('its a hard knock life', 'surrey', '456-654-4567', 'harv@hkl.com'),
    ('its a hard knock life', 'vancouver', '604-654-4567', 'harv@hkl.com'),
    ('its a hard knock life', 'victoria', '250-654-4567', 'harv@hkl.com'),
    ('its a hard knock life', 'langford', '778-654-4567', 'harv@hkl.com');


create table member (
    member_id serial primary key,
    member_name varchar(255),
    member_phone varchar(15),
    member_email varchar(255)
);

insert into member (member_name, member_phone, member_email) values
    ('Boris', '250-123-4567', 'boris.badenov@gmail.com'),
    ('Natasha', '250-234-5678', 'natasha.fatale@gmail.com'),
    ('Rocky', '250-345-6789', 'rocky.squirrel@gmail.com'),
    ('Bullwinkle', '250-456-7890', 'bullwinkle.moose@gmail.com'),
    ('Fearless', '250-567-8901', 'fearless.leader@gmail.com'),
    ('Jules', '250-111-1111', 'jules@gmail.com'),
    ('Vincent', '250-222-2222', 'vincent@gmail.com'),
    ('Mia', '250-333-3333', 'mia@gmail.com'),
    ('Butch', '250-444-4444', 'butch@gmail.com'),
    ('Marcellus', '250-555-5555', 'marcellus@gmail.com'),
    ('Winston', '250-666-7777', 'winston.wolf@gmail.com'),
    ('Bruce', '250-777-7777', 'bruce@gmail.com'),
    ('Samuel', '250-888-8888', 'samuel@gmail.com'),
    ('Quentin', '250-999-9999', 'quentin@gmail.com'),
    ('Henrik', '250-123-4567', 'henrik@gmail.com'),
    ('Daniel', '250-234-5678', 'daniel@gmail.com'),
    ('Pavel', '250-345-6789', 'pavel@gmail.com'),
    ('Richard', '250-456-7890', 'richard@gmail.com'),
    ('Erlich', '250-567-8901', 'erlich@gmail.com'),
    ('Jared', '250-678-9012', 'jared@gmail.com');


create table employee (
    employee_id serial primary key,
    employee_name varchar(255),
    position varchar(255),
    salary decimal(10, 2),
    date_hired date
);

insert into employee (employee_name, position, salary, date_hired) values
    ('Mei Ling', 'Head of Donations', 25000.00, '2023-03-05'),
    ('Alice Johnson', 'Manager', 35000.00, '2023-01-15'),
    ('Mohammed Khan', 'Assistant Manager', 30000.00, '2023-02-10'),
    ('Jackson Smith', 'Marketing Specialist', 28000.00, '2023-04-20'),
    ('Fatima Patel', 'Accountant', 32000.00, '2023-05-12'),
    ('Ethan Thompson', 'Customer Service Representative', 23000.00, '2023-06-30');


create table donor (
    donor_id serial primary key,
    donor_name varchar(255),
    primary_donor_contact varchar(255),
    amount decimal(10, 2),
    donor_phone varchar(15)
);


insert into donor (donor_name, primary_donor_contact, amount, donor_phone)
values
    ('eco inc', 'homer', 25000, '123-456-7890'),
    ('saveearth foundation', 'bart', 50000, '234-567-8901'),
    ('cleantech innovations', 'marge', 30000, '345-678-9012'),
    ('greenfuture group', 'lisa', 20000, '456-789-0123'),
    ('eco corp', 'maggie', 40000, '567-890-1234'),
    ('sustainable solutions', 'ned', 35000, '678-901-2345'),
    ('renewable resources ltd.', 'milhouse', 28000, '789-012-3456'),
    ('planetpreservers', 'nelson', 100000, '890-123-4567');


create table office (
    office_id serial primary key,
    office_address varchar(255),
    office_phone varchar(15),
    rent decimal(10, 2)
);

insert into office (office_id, office_address, office_phone, rent)
values (1, '123 Beach Avenue, Victoria, BC V8N 2J5, Canada', '250-123-4567', 3500);


create table website (
    url varchar(255) primary key,
    twitter varchar(255),
    facebook varchar(255)
);

insert into website (url, twitter, facebook)
values
    ('https://jamesbaybeachfires.com', '@jamesbaybeachfires', 'https://facebook.com/JamesBayBeachFires'),
    ('https://icecreampleasures.com', '@icecreampleasures', 'https://facebook.com/IceCreamPleasures');


create table campaign (
    campaign_id serial primary key,
    campaign_name varchar(255),
    start_date date,
    end_date date,
    phase varchar(255),
    budget decimal(10, 2)
);

insert into campaign (campaign_name, start_date, end_date, phase, budget)
values
    ('Bring Back the James Bay Beach Fires', '2024-08-15', '2024-09-15', 'Monitoring', 12000),
    ('Not Enough Ice Cream For Everyone', '2024-10-10', '2024-11-10', 'Planning', 9500),
    ('Big Trees, Big Yes!', '2024-06-01', '2024-07-01', 'Execution', 8000);


create table expenses (
    campaign_id int references campaign(campaign_id),
    material varchar(255),
    description text,
    cost decimal(10, 2),
    date_of_purchase date
);

insert into expenses (campaign_id, material, description, cost, date_of_purchase)
values
    (2, 'Posters', 'Printing', 500, '2024-05-15'),
    (2, 'Placards', 'Volunteer supplies', 300, '2024-05-20'),
    (2, 'Firewood', 'Beach event supplies', 700, '2024-08-10'),
    (2, 'Marshmallows', 'Bonfire event', 200, '2024-08-12'),
    (3, 'Ice Cream Cones', 'Refreshments', 400, '2024-10-25'),
    (3, 'T-shirts', 'Volunteer attire', 600, '2024-10-30'),
    (3, 'Flyers', 'Advertising materials', 300, '2024-05-10'),
    (2, 'Blankets', 'Beach event supplies', 600, '2024-08-08'),
    (3, 'Hot dogs', 'Bonfire event refreshments', 150, '2024-08-12'),
    (4, 'Balloons', 'Decoration', 200, '2024-10-20'),
    (4, 'Posters', 'Printing', 900, '2024-05-18'),
    (4, 'Placards', 'Volunteer supplies', 100, '2024-05-25'),
    (4, 'T-shirts', 'Promotional attire', 1100, '2024-11-02'),
    (4, 'Flyers', 'Advertising materials', 200, '2024-05-18');


create table volunteer (
    volunteer_id serial primary key,
    volunteer_name varchar(255),
    tier varchar(255),
    volunteer_phone varchar(15),
    volunteer_email varchar(255)
);

insert into volunteer (volunteer_name, tier, volunteer_phone, volunteer_email)
values
    ('cloud', 'one', '250-123-4567', 'cloud@gmail.com'),
    ('tifa', 'two', '250-234-5678', 'tifa@gmail.com'),
    ('chandra', 'one', '250-456-7890', 'chandra@gmail.com'),
    ('Boris', 'one', '250-123-4567', 'boris.badenov@gmail.com'),
    ('george', 'two', '250-901-2345', 'george@gmail.com'),
    ('tupac', 'two', '250-123-4567', 'tupac@gmail.com'),
    ('biggie', 'two', '250-234-5678', 'biggie@gmail.com'),
    ('shakespeare', 'one', '250-123-4567', 'shakespeare@gmail.com'),
    ('Bullwinkle', 'one', '250-456-7890', 'bullwinkle.moose@gmail.com'),
    ('williams', 'two', '250-345-6789', 'williams@gmail.com'),
    ('hansberry', 'one', '250-456-7890', 'hansberry@gmail.com'),
    ('hitchcock', 'two', '250-567-8901', 'hitchcock@gmail.com'),
    ('spielberg', 'two', '250-678-9012', 'spielberg@gmail.com'),
    ('leonardo', 'two', '250-999-8888', 'leonardo.turtle@gmail.com'),
    ('natasha', 'two', '250-234-5678', 'natasha@gmail.com'),
    ('Mia', 'two', '250-333-3333', 'mia@gmail.com'),
    ('Vincent', 'one', '250-222-2222', 'vincent@gmail.com'),
    ('Butch', 'one', '250-444-4444', 'butch@gmail.com'),
    ('Marcellus', 'two', '250-555-5555', 'marcellus@gmail.com'),
    ('coppola', 'two', '250-901-2345', 'coppola@gmail.com'),
    ('keynes', 'one', '250-012-3456', 'keynes@gmail.com'),
    ('friedman', 'two', '250-234-5678', 'friedman@gmail.com'),
    ('krugman', 'one', '250-345-6789', 'krugman@gmail.com'),
    ('Henrik', 'two', '250-123-4567', 'henrik@gmail.com'),
    ('Daniel', 'two', '250-234-5678', 'daniel@gmail.com'),
    ('zack', 'one', '250-678-9012', 'zack@gmail.com'),
    ('kelly', 'two', '250-789-0123', 'kelly@gmail.com'),
    ('acslater', 'two', '250-890-1234', 'acslater@gmail.com'),
    ('jessie', 'one', '250-901-2345', 'jessie@gmail.com'),
    ('lisa', 'two', '250-012-3456', 'lisa@gmail.com'),
    ('jules', 'one', '250-111-1111', 'jules@gmail.com'),
    ('vincent', 'two', '250-222-2222', 'vincent@gmail.com');


create table event (
    event_id serial primary key,
    event_name varchar(255),
    event_location varchar(255),
    event_description text,
    event_date date
);

insert into event (event_name, event_location, event_description, event_date)
values
    ('#mofire', 'james bay beach', 'cleanup to support', '2024-08-27'),
    ('ice cream social', 'main street plaza', 'social event', '2024-10-22'),
    ('diy ice cream workshop', 'community center', 'workshop', '2024-11-07'),
    ('save the big tree', 'civic center plaza', 'tree-saving event', '2025-04-20'),
    ('beach cleanup party', 'coastal community beach', 'cleanup party', '2025-07-02');


create table fundraiser (
    event_id int primary key references event(event_id),
    target_goal decimal(10, 2),
    funds_raised decimal(10, 2),
    sponsorship varchar(255)
);

insert into fundraiser (target_goal, funds_raised, sponsorship)
values
    (1, 5000, 2000, 'Local businesses sponsorships'),
    (2, 3000, 1500, 'Community donations and grants');



#Relationship Sets:



create table comprises (
    gng_id int,
    company_id int,
    member_id int,
    primary key (gng_id, company_id, member_id),
    foreign key (gng_id) references green_not_greed(gng_id),
    foreign key (company_id) references global_affiliate(company_id),
    foreign key (member_id) references member(member_id)
);

insert into comprises (gng_id, company_id, member_id) values (5, 1, 8), (5, 1, 13), (5, 2, 10), (5, 3, 6), (5, 4, 2), (5, 4, 4), (5, 5, 17), (5, 6, 15), (5, 7, 12), (5, 8, 11), (5, 8, 1), (5, 9, 20);


create table employs (
    gng_id int,
    employee_id int,
    primary key (gng_id, employee_id),
    foreign key (gng_id) references green_not_greed(gng_id),
    foreign key (employee_id) references employee(employee_id)
);

insert into employs (gng_id, employee_id) values (4, 1), (5, 2), (5, 3), (3, 4), (1, 6), (2, 6), (3, 6);


create table supports (
    gng_id int,
    donor_id int,
    primary key (gng_id, donor_id),
    foreign key (gng_id) references green_not_greed(gng_id),
    foreign key (donor_id) references donor(donor_id)
);

insert into supports (gng_id, donor_id) values (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8);


create table located_at (
    gng_id int,
    office_id int,
    primary key (gng_id, office_id),
    foreign key (gng_id) references green_not_greed(gng_id),
    foreign key (office_id) references office(office_id)
);

insert into located_at (gng_id, office_id) values (1, 1), (2, 1), (3, 1);


create table organizes (
    gng_id int,
    campaign_id int,
    primary key (gng_id, campaign_id),
    foreign key (gng_id) references green_not_greed(gng_id),
    foreign key (campaign_id) references campaign(campaign_id)
);

insert into organizes (gng_id, campaign_id) values (1, 2), (1, 3), (1, 4), (2, 2), (2, 3), (2, 4);


create table represents (
    url varchar(255),
    campaign_id int,
    primary key (url, campaign_id),
    foreign key (url) references website(url),
    foreign key (campaign_id) references campaign(campaign_id)
);

insert into represents (url, campaign_id) values
    ('https://jamesbaybeachfires.com', 3),
    ('https://icecreampleasures.com', 4);


create table participates (
    event_id int,
    volunteer_id int,
    primary key (event_id, volunteer_id),
    foreign key (event_id) references event(event_id),
    foreign key (volunteer_id) references volunteer(volunteer_id)
);

insert into participates (event_id, volunteer_id) values (1, 23), (2, 6), (3, 30), (5, 15), (3, 11), (2, 27), (1, 5), (1, 4), (5, 29), (3, 20), (4, 3), (1, 16), (2, 32), (2, 17), (3, 14), (4, 8), (2, 26), (1, 10), (3, 1), (5, 28), (3, 22), (4, 12), (2, 7), (1, 13), (4, 25), (5, 31), (2, 18), (3, 19), (4, 9), (1, 24), (5, 21), (2, 2);


create table plans (
    campaign_id int,
    event_id int,
    primary key (campaign_id, event_id),
    foreign key (campaign_id) references campaign(campaign_id),
    foreign key (event_id) references event(event_id)
);

insert into plans (campaign_id, event_id) values (2, 4), (3, 5), (3, 1), (4, 2), (4, 3);






    