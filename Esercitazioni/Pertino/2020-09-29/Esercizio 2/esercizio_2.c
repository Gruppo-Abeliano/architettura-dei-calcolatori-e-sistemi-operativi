int vett[10] = {1,2,3,4,5,6,7,8,9,10};
int max;
int i;

int main()
{
    max = vett[0];

    for(i=0;i<10;i++)
    {
      if(vett[i]>max) max=vett[i];
    }
}
