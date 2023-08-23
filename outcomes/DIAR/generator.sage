class Generator(BaseGenerator):
    def data(self):
        x = var('x')

        n = randrange(3,10);
        m = randrange(4,10);

        monomial(x) = x^n;
        poly(x) = randrange(1,10)*choice([-1,1])*x^3 + sum(randrange(-9,10)*x^i for i in range(3));


        rule_choice = choice(["s","p","q","c"]);

        rule_f_dict = {
            "s": monomial(x) + (poly(x))^m,
            "p": monomial(x)*(poly(x))^m,
            "q": monomial(x)/(poly(x))^m,
            "c": monomial(poly(x)),
            }
        
        dd=derivative(rule_f_dict[rule_choice],x)
        ddnd=dd.numerator_denominator();

        if rule_choice == "p":
            rule_string = "PRODUCT";
            d_answer = dd;
        elif rule_choice == "q":
            rule_string = "QUOTIENT (or PRODUCT)";
            d_answer = ddnd[0]/ddnd[1];
        elif rule_choice == "c":
            rule_string = "CHAIN";
            d_answer = dd;
        else:
            rule_string = "SUM";
            d_answer = dd;
        



        return {
            "f": rule_f_dict[rule_choice],
            "rs": rule_string,
            "deriv": d_answer,
        }