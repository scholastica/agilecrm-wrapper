AgileCRM Ruby Client
=================

This project is a ruby client that wraps the [AgileCRM REST API](https://www.agilecrm.com/api/rest). **Note: This is not an official project, you're welcome to use it but don't expect the AgileCRM team to support it.**

At present, only operations related to the **contacts** resource are supported. This client is early in development, but it will slowly evolve to support other kinds of operations. Pull requests are always welcome.

## Installation

Add this line to your application's Gemfile:

    gem 'agilecrm', github: 'nozpheratu/agilecrm-ruby-api'

And then execute:

    $ bundle

# Usage

To begin using this gem, Initialize the library using a configuration block including your agile **API key**, **email**, and **domain**, like this:

```ruby
AgileCRM.configure do |config|
  config.api_key = 'XXXXXXXXXXX'
  config.domain = 'my-agile-domain'
  config.email = 'myemail@example.com'
end
```

### 1. Working with Contacts

**GET** operations return one or more `AgileCRM::Contact` objects. These are just `Hashie::Mash` objects with a few utility methods sprinkled on. You can access any of the Contact fields returned by AgileCRM's REST API, see [here](https://www.agilecrm.com/api/rest#contact-fields) for what that entails. Example:
```ruby
contact = AgileCRM::Contact.find(123)
contact.tags       #=> ["tag", "your", "it"]
contact.id         #=> 123
contact.properties #=> [{ type: 'SYSTEM', name: "email", value: "blah@mail.com" }]
```

###### To retrieve a list of contacts
```ruby
AgileCRM::Contact.all
```

###### To get an individual contact by ID
```ruby
AgileCRM::Contact.find(123)
```

###### To find contacts by email
```ruby
contact = AgileCRM::Contact.search_by_email("foo@example.com")
# or pass multiple emails as seperate arguments or an array
contacts = AgileCRM::Contact.search_by_email(
"foo@example.com", "bar@example.com"
)
```

###### To create a new contact
```ruby
AgileCRM::Contact.create(
  tags: ["tag", "your", "it"],
  first_name: "Justin",
  last_name: "Case",
  email: "blah@mail.com",
  my_custom_field: "im a custom field!"
)
```

###### To update a single contact
```ruby
contact.update(first_name: "Foo", last_name: "Bar", tags: ["new_tag"])
```

Note, tags specified in `update` will simply be added to the existing list of tags.

###### To delete a single contact
```ruby
# perform operation directly
AgileCRM::Contact.delete(123)
# or
AgileCRM::Contact.find(123).destroy
```

###### Convenient access to properties hash values
```ruby
contact.get_property("email")            #=> "blah@mail.com"
contact.get_propety("my_custom_field")   #=> "im a custom field!"
contact.get_property("unkown_attribute") #=> nil
```

### 2. Working with Notes

###### To create a new note
```ruby
AgileCRM::Note.create(
  subject: "My Note",
  description: "My notes's description.",
  contact_ids: ["123"]
)
```

###### To add a Note to a Contact using Email-ID
```ruby
AgileCRM::Note.add_by_email(
  email: "blah@mail.com",
  subject: "My Note",
  description: "My notes's description."
)
```


## Contributing

1. Fork it ( https://github.com/nozpheratu/agilecrm-ruby-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
