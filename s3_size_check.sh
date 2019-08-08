#!/bin/bash

aws s3api list-objects --bucket bookstore-diz-storage --query "[sum(Contents[].Size), length(Contents[])]"
