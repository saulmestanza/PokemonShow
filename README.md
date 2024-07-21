# Presentation

I used `block state management`, although for a project of this size I would first consider something more suitable like `provider`, I wanted to use the `block` to demonstrate your knowledge.

The packages I used were:
`flutter_bloc` and `bloc_test` for state management and for testing
`shared_preferences` to save `logged in` state after app reload
`http` to make API calls
`equatable` for comparison objects for state management
`intl` and `intl_utils` to format date and generate int texts
`flutter_widget_from_html` to display the html texts that the show api responded to

I first developed the list of Pokemon shows, i wanted to start with the more complex screens, i chose that layout, the vertical card layout, to show the most of the image. Trying to be minimalist by simply displaying the show name, status and release date.

I choose the show details screen so that the image is something like a header, and all the information can be scrolled behind it.

As I finished getting started with the login screen, I did persistent login validation with shared preferences after a successful login. if you are logged in, continue; otherwise, you must enter credentials.

I choose intl the text to have better support for other languages ​​in the future, and because as a small project that can grow it is better to start without having coded the text.