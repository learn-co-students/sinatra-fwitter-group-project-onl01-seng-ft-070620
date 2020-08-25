User.create(username: "Bill", email: "bill@test.com", password_digest: "123")
User.create(username: "Till", email: "till@test.com", password_digest: "123")
User.create(username: "Hill", email: "hill@test.com", password_digest: "123")

Tweet.create(content: "Run of the bill", user_id: 1)
Tweet.create(content: "Run of the bill part 2", user_id: 1)
Tweet.create(content: "Run of the bill part 3", user_id: 1)

Tweet.create(content: "Run of the till", user_id: 2)
Tweet.create(content: "Run of the till part 2", user_id: 2)
Tweet.create(content: "Run of the till part 3", user_id: 2)

Tweet.create(content: "Run of the hill", user_id: 3)
Tweet.create(content: "Run of the hill part 2", user_id: 3)
Tweet.create(content: "Run of the hill part 3", user_id: 3)
