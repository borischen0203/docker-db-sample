CREATE TABLE `users` (
  `id` BIGINT auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

insert into users(name) values('Boris');
