class Generator(BaseGenerator):
    def data(self):

        scenario = choice(["fixA","fixV"])
        topQ = choice([" with a top."," without a top."])

        #fixA scenario
        if scenario=="fixA":
            A = 6*randrange(1,25)
            xcrit = sqrt(A/6)
            if topQ==" with a top.":
                ycrit = (A-2*xcrit^2)/(4*xcrit)
            else:
                ycrit = (A-2*xcrit^2)/(3*xcrit)

            return {
                scenario: True,
                "A": A,
                "topQ": topQ,
                "Vmax": xcrit^2*ycrit,
                "Vmax_approx": round(xcrit^2*ycrit,2),
            }



        #fixV scenario
        if scenario=="fixV":
            c = randrange(2,10)
            if topQ==" with a top.":
                eps=1
            else:
                eps=0
            V0 = 2*c^2*randrange(1,20);
            bcrit_cubed = V0*(c+1)/(c^2*(eps+1));
            bcrit = bcrit_cubed^(1/3);
            hcrit = V0/(c*bcrit^2);
            return {
                scenario: True,
                "c":c,
                "V0":V0,
                "topQ": topQ,
                "Amin": V0*(2*c+2)/(c*bcrit)+c*(eps+1)*bcrit^2,
                "Amin_approx": round(V0*(2*c+2)/(c*bcrit)+c*(eps+1)*bcrit^2,2),
            }