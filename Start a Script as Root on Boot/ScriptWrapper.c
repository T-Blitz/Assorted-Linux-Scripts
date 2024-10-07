int main(void) {        
    setuid(0);
    clearenv();
    system("/absolute/path/to/your/script.sh");
}
