package airport.exception;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.TypeMismatchException;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerAdvice {

    @ExceptionHandler(AccessDeniedException.class)
    public ModelAndView handleAccessDenied(AccessDeniedException e, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView("redirect:/profile");
        redirectAttributes.addFlashAttribute("errorMessage", "Доступ запрещен. У вас недостаточно прав для выполнения данного действия.");
        return mav;
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView handleValidationException(MethodArgumentNotValidException e) {
        ModelAndView mav = new ModelAndView("errors/400");

        Map<String, String> fieldErrors = new HashMap<>();
        e.getBindingResult().getFieldErrors().forEach(error ->
                fieldErrors.put(error.getField(), error.getDefaultMessage()));

        mav.addObject("fieldErrors", fieldErrors);

        return mav;
    }

    @ExceptionHandler({
            IllegalArgumentException.class,
            HttpMessageNotReadableException.class
    })
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView handleBadRequestExceptions(Exception e) {
        ModelAndView mav = new ModelAndView("errors/400");
        mav.addObject("error",  e.getMessage());
        return mav;
    }

    @ExceptionHandler(TypeMismatchException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView TypeMismatchException(Exception e) {
        ModelAndView mav = new ModelAndView("errors/400");
        mav.addObject("error",  e.getMessage());
        return mav;
    }

    @ExceptionHandler(InvalidRegisterException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView handleInvalidRegisterException(InvalidRegisterException e) {
        ModelAndView mav = new ModelAndView("auth/register");
        mav.addObject("error", e.getMessage());
        return mav;
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ModelAndView handleAllOtherExceptions(Exception e) {
        ModelAndView mav = new ModelAndView("errors/400");
        mav.addObject("error",  e.getMessage());
        return mav;
    }
}