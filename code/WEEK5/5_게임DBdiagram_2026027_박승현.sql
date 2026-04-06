Table UserAccount {
  user_id int [pk]
  email varchar(100)
  password varchar(100)
  created_at timestamp
}

Table Character {
  character_id int [pk]
  user_id int
  name varchar(100)
  level int
  class varchar(50)
}

Table Item {
  item_id int [pk]
  name varchar(100)
  type varchar(50)
}

Table Inventory {
  character_id int
  item_id int
  quantity int

  indexes {
    (character_id, item_id) [pk]
  }
}

Ref: Character.user_id > UserAccount.user_id
Ref: Inventory.character_id > Character.character_id
Ref: Inventory.item_id > Item.item_id