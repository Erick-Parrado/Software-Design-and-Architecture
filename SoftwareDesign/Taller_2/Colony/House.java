package Colony;

class House{
    // * * Attribute declaring
    private String name; 
    public String postalAddress;
    private String nameStreet;
    private String postalCode;
    public int capacity;
    private Director[] directors;
    private Tutor[] tutors;
    private Kid[] kids;
    private Region region;
    private Activity[] activities;

    public House(String name, String postalCode, String nameStreet, int capacity, Region region){}

    public String readHouse(){return "";}

    public void updateHouse(String name, int capacity){}

    public void deleteHouse(){}

    public void addKid(Kid newKid){}

    public void addActivity(Activity newActivity){}
}