//=============================================================================================================
/**
* @file     ISensor.h
* @author   Christoph Dinh <chdinh@nmr.mgh.harvard.edu>;
*           Matti Hamalainen <msh@nmr.mgh.harvard.edu>
* @version  1.0
* @date     February, 2013
*
* @section  LICENSE
*
* Copyright (C) 2013, Christoph Dinh and Matti Hamalainen. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification, are permitted provided that
* the following conditions are met:
*     * Redistributions of source code must retain the above copyright notice, this list of conditions and the
*       following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
*       the following disclaimer in the documentation and/or other materials provided with the distribution.
*     * Neither the name of the Massachusetts General Hospital nor the names of its contributors may be used
*       to endorse or promote products derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
* PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MASSACHUSETTS GENERAL HOSPITAL BE LIABLE FOR ANY DIRECT,
* INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
*
*
* @brief    Contains declaration of IIinverseAlgorithm interface class.
*
*/

#ifndef IINVERSEALGORITHM_H
#define IINVERSEALGORITHM_H

//*************************************************************************************************************
//=============================================================================================================
// INCLUDES
//=============================================================================================================

#include <QString>


//*************************************************************************************************************
//=============================================================================================================
// FORWARD DECLARATIONS
//=============================================================================================================
namespace FIFFLIB
{
class FiffEvoked;
}


//*************************************************************************************************************
//=============================================================================================================
// DEFINE NAMESPACE INVERSE
//=============================================================================================================

namespace INVERSELIB
{

//*************************************************************************************************************
//=============================================================================================================
// USED NAMESPACES
//=============================================================================================================

using namespace FIFFLIB;


//*************************************************************************************************************
//=============================================================================================================
// FORWARD DECLARATIONS
//=============================================================================================================

class SourceEstimate;


//=============================================================================================================
/**
* Inverse algorithm interface for inverse routines of MNE-CPP
*
* @brief Inverse algorithm interface
*/
class IInverseAlgorithm
{
public:
    //=========================================================================================================
    /**
    * Destroys the IInverseAlgorithm.
    */
    virtual ~IInverseAlgorithm() {};

    //=========================================================================================================
    /**
    * Applies the inverse algorithm to input data and returns a source estimate.
    *
    * @param[in] p_fiffEvoked   Evoked data.
    * @param[in] pick_normal    If True, rather than pooling the orientations by taking the norm, only the
    *                           radial component is kept. This is only applied when working with loose orientations.
    *
    * @return the calculated source estimation
    */
    virtual SourceEstimate calculateInverse(const FiffEvoked &p_fiffEvoked, bool pick_normal = false) const = 0;

    //=========================================================================================================
    /**
    * Returns the algorithm name
    *
    * @return the algorithm name
    */
    virtual const char* getName() const = 0;
};

} //NAMESPACE

#endif // IINVERSEALGORITHM_H