*** Settings ***
Documentation    Test suite configuration variables.

*** Variables ***

#* ===================================================================
#* Endpoints
${API_BASE_URL}                     https://restful-booker.herokuapp.com
${AUTH_ENDPOINT}                    /auth
${BOOKING_ENDPOINT}                 ${API_BASE_URL}/booking
${BOOKING_SESSION}                  booking_session

#* ===================================================================
#* API content

#* ----------------------------------
&{PATCH_BODY}
...    firstname=Fede

&{BOOKING_DATES}
...    checkin=2018-01-01
...    checkout=2019-01-01

&{BOOKING_PAYLOAD}
...    firstname=Jim
...    lastname=Brown
...    totalprice=${111}
...    depositpaid=${True}
...    bookingdates=&{BOOKING_DATES}
...    additionalneeds=Breakfast
#* ----------------------------------
&{BOOKING_PAYLOAD_UPDATE}
    ...    firstname=James
    ...    lastname=Brown
    ...    totalprice=${111}
    ...    depositpaid=${True}
    ...    bookingdates=&{BOOKING_DATES}
    ...    additionalneeds=Breakfast
