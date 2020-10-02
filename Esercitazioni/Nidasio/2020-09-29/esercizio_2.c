// Trova il valore massimo dell'array

int vett[10] = {1, 2, 3, 4, 5, 100, 7, 8, 9, 10};
int max;
int i;

void main()
{
  max = vett[0];
  for (i = 1; i < 10; i++)
    if (vett[i] > max)
      max = vett[i];
}