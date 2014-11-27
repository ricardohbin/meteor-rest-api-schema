@Users = new Meteor.Collection "users"
# TODO: apply simple schema
@UsersSchema = new SimpleSchema
	firstName:
		type: String
		label: "First Name"
		max: 50
	lastName:
		type: String
		label: "First Name"
		max: 50
	email:
		type: String
		label: "E-mail"
		regEx: SimpleSchema.RegEx.Email