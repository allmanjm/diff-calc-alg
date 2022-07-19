class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        
        xs = sample(range(-2,3),2)
        a = min(xs)
        b = max(xs)
            
        coeffs = sample(range(-25,26),4)

        f(x) = coeffs[0]+coeffs[1]*x+coeffs[2]*x^2+coeffs[3]*x^3
            
        
        
        arc = (f(b)-f(a))/(b-a)
        
        
        name = choice(["f","g","p","q","r"])



        return {
            "a": a,
            "b": b,
            "name": name,
            "arc": arc,
            "function": f(x),
            "y0": f(a),
            "deltax0": x-a,
            "pts":[(a,f(a)),(b,f(b))],
        }

    @provide_data
    def graphics(data):
        return{
            "Show": plot(data["function"],(x,data["a"],data["b"]),color="red") + plot(data["y0"]+data["arc"]*(data["deltax0"]),(x,data["a"],data["b"]),color="blue")+point(data["pts"],pointsize=20,color="blue"),
        }
