Contacts-ParseSDK
===============

Its a kinda managing the contacts using Parse SDK. This iOS Application, I enabled the User mechanism.
Like,
        1. Anonymous
        2. Existing
        3. New

So, you don’t have enough time to checkout with existing or new user just go with Anonymous session. This session will be there at once you delete your application. In this Application you can go with Anonymous or Existing User or New User. With help of these different roles of users, Once you got a session then you easily create N no.Of contacts. Once you create the Contacts it will added into your Parse User Table  as well as in your CoreData. Here I am maintaining 3 Different Table RelationShip.
Like,
        1. User
        2. Contacts
        3. Address

So the philosophy here i followed is, The user can have more contacts' as well as the contact will have more than one addresses'. So, This Application is starting with basic profile and information only. but it will give you very basic and neatly way of managing your Contacts.

Here i am followed basic CRUD Functionality:
===========================================
Like,
        1. Create
        2. Read
        3. Update
        4. Delete

So the Above functionalities are works well in this application. You don't worry about that. Its very Basic Application So, Don't think it will full fill your requirements. i think i would have help you in some ways of small bits of parse and contacts. and relationships mechanism. etc.

Relationship
=========

Here I am used One-to-Many relationship. So the basic funda, here is One user can have multiple contacts, and also one Contact will have multiple Address. So if you logging out or delete contact, it should reflect on your relationship,. I used Core-Data & NSFetchResultController for populating the contacts and values on Viewcontrollers.
