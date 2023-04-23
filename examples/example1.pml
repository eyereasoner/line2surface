proves(
    conj(
        t(':Socrates',a,':Human') ,
        impl(
            t(':Socrates',a,':Human') ,
            t(':Socrates',a,':Mortal') 
        )
    ) ,
    t(':Socrates',a,':Mortal') 
)
