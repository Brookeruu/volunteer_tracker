Volunteer Tracker
=================

Author:
Nate McGregor

Description:
------------
A website where someone can create a project, then create volunteers for that project. Both projects and volunteers are able to be updated and deleted.

Setup instructions:
-------------------
make sure ruby is installed on your system, if not go here for instructions on installing ruby: https://www.ruby-lang.org/en/documentation/installation/

run:
```
git clone https://github.com/hal2814/volunteer_tracker
```
```
cd volunteer_tracker
```
```
ruby app.rb
```
and in your browser go to: http://localhost:4567/

Spec:
-----
| Spec                                      | origin                                 | input                  | output                   |
|-------------------------------------------|----------------------------------------|------------------------|--------------------------|
| save a project                            | n/a                                    | "Helping the children" | "Helping the children"   |
| get all names of volunteers for a project | n/a                                    | "Helping the children" | "Steve","Johnny"         |
| Update a project's title                  | "Helping the children"                 | "Helping the Gorillas" | "Helping the Gorillas"   |
| Delete a project                          | "Candle making","Helping the children" | "Helping the children" | "Candle making"          |
| get all volunteer names                   | n/a                                    | n/a                    | "Steve","Johnny","Daryl" |


![alt text](/public/img/screen.png)


copyright Nate McGregor 2017
