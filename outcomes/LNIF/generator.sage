class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        
        # stuff for Task 1
        S1 = sample(range(-5,6),4);
        a = choice([S1[0],S1[1]]);
        r1 = S1[1];
        r2 = S1[2];
        q1 = expand((x-r1)*(x-r2));
        A1 = randrange(1,6);
        p1 = A1*(x-S1[3]);
        top_bottom1 = sample([p1,q1],2);
        numer1(x) = top_bottom1[0];
        denom1(x) = top_bottom1[1];
        f1(x) = numer1(x)/denom1(x);

        if denom1(a) == 0:
            answer1 = "\\text{The limit does not exist.}"
        else:
            answer1 = f1(a)


        # stuff for Task 2
        powers2 = [randrange(1,5) for i in range(2)];
        q2 = (x-r1)^(powers2[0])*(x-r2)^(powers2[1]);
        A23 = randrange(1,6);
        p23 = A23*(x-S1[3]);
        
        top_bottom2 = sample([p23,q2],2);
        numer2(x) = top_bottom2[0];
        denom2(x) = top_bottom2[1];
        f2(x) = numer2(x)/denom2(x);


        if denom2(a) == 0 and powers2[0]%2 == 0:
            if f2(a+0.1) > 0:
                answer2 = "+\\infty"
            else:
                answer2 = "-\\infty"
        elif denom2(a) == 0 and powers2[0]%2 == 1:
            answer2 = "\\text{The limit does not exist.}"
        else:
            answer2 = f2(a)
            




        # stuff for Task 3
        q3 = q1;
        top_bottom3 = sample([p23,q3],2)
        numer3(x) = top_bottom3[0];
        denom3(x) = top_bottom3[1];
        f3(x) = numer3(x)/denom3(x);

        pm = choice(["+","-"]);
        pm_dict = {"+": 1, "-": -1};

        if denom3(a) == 0 and f3(a+pm_dict[pm]*0.5) > 0:
            answer3 = "+\\infty"
        elif denom3(a) == 0 and f3(a+pm_dict[pm]*0.5) < 0:
            answer3 = "-\\infty"
        else:
            answer3 = f3(a)





        return {
            "a": a,
            "f1(x)": f1(x),
            "answer1": answer1,
            "f2(x)": f2(x),
            "answer2": answer2,
            "pm": pm,
            "f3(x)": f3(x),
            "answer3": answer3,
        }