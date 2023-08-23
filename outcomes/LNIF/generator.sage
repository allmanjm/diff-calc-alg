class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        
        S1 = sample(range(-5,6),4);
        a = S1[0];
        r1 = S1[1];
        r2 = S1[2];
        r3 = S1[3];

        r4 = randrange(6,10)*choice([-1,1]);
        r5 = randrange(6,10)*choice([-1,1]);

        # ans = "plug in"
        A_plug = randrange(1,5);
        exp_plug = randrange(1,5)
        p_plug(x) = expand(A_plug*(x-r1)*(x-r4));
        q_plug(x) = (x-r5)^exp_plug*expand((x-r2)*(x-r3));
        f_plug(x) = p_plug/q_plug;
        ans_plug = f_plug(a);

        
        # ans = "zero"
        A_zero = randrange(1,5);
        exp_zero = randrange(1,5);
        p_zero(x) = expand((x-a)*(x-r5));
        q_zero(x) = (x-r3)^(exp_zero)*expand((x-r1)*(x-r2));

        f_zero(x) = p_zero/q_zero;
        ans_zero = 0;


        # twoside
        exp_twoside = randrange(1,9);
        exp_twoside1 = randrange(1,3);
        exp_twoside2 = randrange(1,3);
        exp_twoside3 = randrange(1,3);
        exp_twoside4 = randrange(1,4);
        exp_twoside5 = randrange(1,4);
        p_twoside(x) = (x-r1)^exp_twoside1*(x-r2)^exp_twoside2*(x-r3)^exp_twoside3;
        q_twoside(x) = (x-a)^exp_twoside*(x-r4)^exp_twoside4*(x-r5)^exp_twoside5;
        f_twoside(x) = p_twoside/q_twoside;

        if exp_twoside%2 == 0:
            if f_twoside(a+0.1)>0:
                ans_twoside = "+\\infty"
            else:
                ans_twoside = "-\\infty"
        else:
            ans_twoside = "\\text{The limit does not exist.}"




        # oneside
        exp_oneside = randrange(1,9);
        exp_oneside1 = randrange(1,3);
        exp_oneside2 = randrange(1,3);
        exp_oneside3 = randrange(1,3);
        exp_oneside4 = randrange(1,4);
        exp_oneside5 = randrange(1,4);
        p_oneside(x) = (x-r1)^exp_oneside1*(x-r2)^exp_oneside2*(x-r3)^exp_oneside3;
        q_oneside(x) = (x-a)^exp_oneside*(x-r4)^exp_oneside4*(x-r5)^exp_oneside5;
        f_oneside(x) = p_oneside(x)/q_oneside(x);
        f4(x) = f_oneside(x);

        pm = choice(["+","-"]);
        pm_dict = {"+": 1, "-": -1};

        if f4(a+pm_dict[pm]*0.5) > 0:
            answer4 = "+\\infty"
        else:
            answer4 = "-\\infty"

        f_tuple = sample([(f_plug(x),ans_plug),(f_zero(x),ans_zero),(f_twoside(x),ans_twoside)],3);





        return {
            "a": a,
            "f1": f_tuple[0][0],
            "answer1": f_tuple[0][1],
            "f2": f_tuple[1][0],
            "answer2": f_tuple[1][1],
            "f3": f_tuple[2][0],
            "answer3": f_tuple[2][1],
            "pm": pm,
            "f4": f4(x),
            "answer4": answer4,
        }