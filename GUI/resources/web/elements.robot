*** Variables ***

#* ---------------------------
#* Web Element IDs
#* ---------------------------

${ID_USERNAME_INPUT}                             id:user-name
${ID_PASSWORD_INPUT}                             id:password
${ID_LOGIN_BUTTON}                               id:login-button

${ID_CHECKOUT_FIRST_NAME}                        id:first-name
${ID_CHECKOUT_LAST_NAME}                         id:last-name
${ID_CHECKOUT_POSTAL_CODE}                       id:postal-code
${ID_CHECKOUT_FINISH_BUTTON}                     finish

#* ---------------------------
#* Web Element Classes
#* ---------------------------

${CLASS_PRODUCTS_SORT_CONTAINER}                  product_sort_container
#* ---------------------------
#* Web Element CSS Selectors
#* ---------------------------

${CSS_SELECTOR_ITEM_PRICE}                        .inventory_item_price
${CSS_BURGER_MENU_BUTTON}                         react-burger-menu-btn
${CSS_LOGOUT_BUTTON}                              logout_sidebar_link
${CSS_INPUT_USERNAME}                             input[name="user-name"]
${CSS_INPUT_PASSWORD}                             input[name="password"]
${CSS_INPUT_SUBMIT}                               input[type="submit"]


#* ---------------------------
#* XPath Selectors
#~ //span[contains(text(), 'Product')]
#~ //*[@class='titulo-producto']
#~ //div[@id='header_container']//span
#* ---------------------------

${XPATH_ADD_TO_CART_BUTTON}                      //button[contains(text(),'Add to cart')]
${XPATH_CHECKOUT_BUTTON}                         //button[normalize-space(text())='Checkout']
${XPATH_CONTINUE_BUTTON}                         //input[@value='Continue']
${XPATH_PRODUCTS_TITLE}                          //span[text()='Products']
${XPATH_ERROR_AT_LOGIN}                          //h3[@data-test="error"]
${XPATH_INVENTORY_LIST}                          //div[@class='inventory_list']
${XPATH_CART_PROD_LIST}                          //div[@class='cart_list']
${XPATH_REMOVE_PRODUCT}                          (//button[text()='Remove'])[1]
${XPATH_CHECKOUT_ERROR}                          //h3[contains(@data-test, "error")]
${XPATH_FINISH_BUTTON}                           //span[text()='Finish']
