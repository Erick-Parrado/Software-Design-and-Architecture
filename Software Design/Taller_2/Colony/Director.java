package Colony;

class Director extends Tutor{
    public Director(String name, String phone){
        super(name,phone);
    }

    public String readDirector(){return "";}

    public void updateDirector(String name, String phone){
        super.updateTutor(name, phone);
    }

    public void deleteDirector(){}
}

