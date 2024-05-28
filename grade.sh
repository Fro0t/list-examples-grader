CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then
    echo "ListExamples.java file found."
else
    echo "ListExamples.java file not found."
    echo "Grade: 0"
    exit
fi

cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area

cd grading-area
javac -cp $CPATH *.java
echo "The exit code for the compile step is $?."
if [[ $? -ne 0 ]]
then
  echo "Grade: 0"
  exit
fi

javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples
