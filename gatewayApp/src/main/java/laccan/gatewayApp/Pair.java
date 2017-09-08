package laccan.gatewayApp;

public class Pair<F, S> {

	private F f;
    private S s;

    public Pair(F f, S s){
        this.f = f;
        this.s = s;
    }

    public F getFirst(){ return f; }
    public S getSecond(){ return s; }
    public void setL(F f){ this.f = f; }
    public void setR(S s){ this.s = s; }
}
