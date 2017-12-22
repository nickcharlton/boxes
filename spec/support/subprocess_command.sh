#!/bin/sh

echo "A happy output."

>&2 echo "An unhappy output."

exit 5
