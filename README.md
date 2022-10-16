# AIRBNB THE CLONE VERSION

This project was built as an assignment in my internship period at Golden Owl Consulting.

![Airbnb Clone homepage](/app/assets/readme_images/homepage.JPG)

## Table of Contents

- [Requirement](#requirement)
- [Getting started](#getting_started)
- [Main functionalities](#main_functionalities)
  - [User authetication](#user_authentication)
  - [Property create process](#property_create)
  - [Display properties](#display_properties)
  - [Reservation create process](#reservation_create)
  - [Admin page](#admin_page)
  - [Realtime notification system](#notification_system)
  - [Review system](#review_system)

<a name="requirement"></a>

## Requirement

This project require you to have Ruby version 3.0.3 and Rails version 6.0.5, if you do not have any of these. Please install with below tutorials:

- [Install Ruby](https://www.theodinproject.com/lessons/ruby-installing-ruby)
- [Install Rails](https://www.theodinproject.com/lessons/ruby-on-rails-installing-rails)

<a name="getting_started"></a>

## Getting started

Clone the project to your local:

```
git@github.com:vinhbt241/airbnb-clone.git
```

Run the following commands:

```
bundle
rails db:migrate
rails db:seed
```

In config folder, create a file name application.yml, then pass the following content:

```
stripe_api_key: "sk_test_51Lg2eyI8S0KFutb7Rs62rz2BNxXHNQ5Zk5mRr1SNDRmo8cedl6ZrCggNa2VTLkxHGMoLeYLUN1J94rXrXLNDhlW000CqNlATSQ"
stripe_publishable_key: "pk_test_51Lg2eyI8S0KFutb7zfl2GL7LUZ2NweILuzK94dJ9jTF4iIJxwDzagYVX5sKz7tW2rblaJVc7ckzMCTCeEDdqy4B500NkfRSljB"
```

To start server http://localhost:3000/, simply type:

```
./bin/dev
```

The current application come with 1 default admin account and 1 default user account, you can check it out:

```
Admin account's email: exampleadmin@gmail.com
password: admin123

User account's email: exampleuser@gmail.com
password: user123
```

<a name="main_functionalities"></a>

## Main functionalities

<a name="user_authentication"></a>

### User authentication

User can create account and login/signout. This process also require email confirmation

![Signup/Login modal](/app/assets/readme_images/login_modal.JPG)
![Signup/Login modal](/app/assets/readme_images/login_page.JPG)
![Signup/Login modal](/app/assets/readme_images/account_confirm.JPG)

<a name="property_create"></a>

### Property create process

User can add their own homestay by fill up multi-step form include add homestay's address, images (minimum amount is 5), name, description and price. User will also have to submit an authentication image if not have one.

![Signup/Login modal](/app/assets/readme_images/add_homestay_information.JPG)
![Signup/Login modal](/app/assets/readme_images/add_identification_images.JPG)
![Signup/Login modal](/app/assets/readme_images/add_identification_images.JPG)

<a name="display_properties"></a>

### Display properties

Active homestay (ready for rent) will be displayed in homepage. Distance (in km unit) from homestay to user will be display, moreover, homestay's default image, price, and reviews are also displayed.

![Signup/Login modal](/app/assets/readme_images/display_property.JPG)

<a name="reservation_create"></a>

### Reservation create process

User choose their favorite homestay, choose duration of stay, then start payment process through Stripe. Then, homestay's owner will confirm reservation. This process will includes noticed emails when user make their reservation (send to owner) and when owner confirm reservation (send to user).

![Signup/Login modal](/app/assets/readme_images/make_reservation.JPG)
![Signup/Login modal](/app/assets/readme_images/billing.JPG)
![Signup/Login modal](/app/assets/readme_images/stripe_checkout.JPG)
![Signup/Login modal](/app/assets/readme_images/reservation_sennd.JPG)
![Signup/Login modal](/app/assets/readme_images/reservation_confirm.JPG)

<a name="admin_page"></a>

### Admin authorization

The application will have admin with highest authority. Admin will have rights to update homestay's information, status. Homestays created by user must be confirmed by admin by set status to "Active" to display on homepage and start renting processes.

![Signup/Login modal](/app/assets/readme_images/admin_page.JPG)
![Signup/Login modal](/app/assets/readme_images/set_status_homestay.JPG)

<a name="notification_system"></a>

### Real time notification system

When users complete their's reservation process. Not only noticed emails will be sent to owner but their news feed will also get noticed in real time thanks to Action Cable.

![Signup/Login modal](/app/assets/readme_images/realtime_notification.JPG)

<a name="review_system"></a>

### Review system

After complete their trip, users can leave a reviews about their experience at homestay.

![Signup/Login modal](/app/assets/readme_images/reservation_status.JPG)
![Signup/Login modal](/app/assets/readme_images/review_modal.JPG)
